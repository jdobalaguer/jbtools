
function [h,p,F,stats,lme] = stats_meanova(x,l)
    %% [h,p,F,stats,lme] = STATS_MEANOVA(x)
    % mixed effects ANOVA - only nominal regressors!
    
    %% function
    
    % assert
    if ismember('Target',strtrim(l)),  func_error('"Target"  is not a valid label'); end
    if ismember('Subject',strtrim(l)), func_error('"Subject" is not a valid label'); end

    % format data
    s  = size(x);
    tn = length(s);
    tx = arrayfun(@(n)1:n,s,'UniformOutput',false);
    [tx{1:tn}] = ndgrid(tx{:});
    tx = cellfun(@mat2vec,tx,'UniformOutput',false);
    ty = x(:);
    
    % make sure regressors are nominal
    tx = cellfun(@nominal,tx,'UniformOutput',false);
    
    % filter out missing data
    ii = ~isnan(ty);
    ty = ty(ii);
    tx = cellfun(@(t)t(ii),tx,'UniformOutput',false);
    
    % create table
    tbl = table(ty,tx{:},'VariableNames',[{'Target'},{'Subject'},l]);
    
    % effects
    effects = cell(1,numel(l));
    for i = 1:numel(l)
        effects{i} = combnk(l,i);
        effects{i} = mat2cell(effects{i},ones(1,size(effects{i},1)),size(effects{i},2));
    end
    effects = cat(1,effects{:});
    effects = cellfun(@(c)strjoin(c,'*'),effects,'UniformOutput',false);
    
    % fit linear mixed model
    modelspec = ['Target ~ ',strjoin(effects,' + '),' + (1|Subject)'];
    lme = fitlme(tbl,modelspec);
    
    % ANOVA
    stats = anova(lme);
    
    % return
    p   = stats.pValue(2:end);
    h   = (p < 0.05);
    F   = stats.FStat(2:end);
    dfd = stats.DF2(2:end);
    dfn = stats.DF1(2:end);
    
    % print
    if ~nargout
        for i = 1:numel(h)
            fprintf('Effect %02d: %-18s F(%3.2f,%3.2f)=%4.3f,\tp=%4.3f \n',i,effects{i},dfn(i),dfd(i),F(i),p(i));
        end
    end
    
end
