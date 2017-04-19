
function [lme,effects] = stats_lme(x,l)
    %% [lme,effects] = STATS_LME(x)
    % linear mixed effects model
    % x : matrix. the data, with one dimension per factor
    %             the first dimension correspond must correspond to subjects
    %             and nans for missing values
    % l : cell of strings. one label per factor
    
    %% function
    
    % default
    func_default('l',num2cell(char('A'+(0:ndims(x)-2))));
    
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
end
