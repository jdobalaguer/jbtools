
function [h,p,F,stats,rm] = stats_rmanova(x,l)
    %% [h,p,F,stats,rm] = STATS_RMANOVA(x)
    % parametric repeated measures ANOVA
    
    %% function
    
    % reshape data
    s = size(x);
    r = arrayfun(@(n)ones(1,n),s,'UniformOutput',false);
    r{1} = size(x,1);
    data = mat2cell(x,r{:});
    data = data(:,:);
    
    % define labels
    labels = arrayfun(@(n)1:n,s(2:end),'UniformOutput',false);
    [labels{1:ndims(x)-1}] = ndgrid(labels{:});
    for i=1:length(l), labels{i}=mat2vec(num2leg(labels{i},[l{i},'%d'])); end
    
    % create table
    tbl = table(data{:},'VariableNames',strcat(labels{:}));
    within = table(labels{:},'VariableNames',l);

    % rm model
    modelspec = [strjoin(strcat(labels{:}),','),'~1'];
    rm = fitrm(tbl,modelspec,'WithinDesign',within);
    
    % effects
    effects = cell(1,numel(l));
    for i = 1:numel(l)
        effects{i} = combnk(l,i);
        effects{i} = mat2cell(effects{i},ones(1,size(effects{i},1)),size(effects{i},2));
    end
    effects = cat(1,effects{:});
    effects = cellfun(@(c)strjoin(c,'*'),effects,'UniformOutput',false);
    
    % rm ANOVA
    stats = ranova(rm,'WithinModel',strjoin(effects,' + '));
    
    % return
    p   = stats.pValue(3:2:end);
    h   = (p < 0.05);
    F   = stats.F(3:2:end);
    dfd = stats.DF(4:2:end);
    dfn = stats.DF(3:2:end);
    
    % print
    if ~nargout
        for i = 1:numel(h)
            fprintf('Effect %02d: %-18s F(%3.2f,%3.2f)=%4.3f,\tp=%4.3f \n',i,effects{i},dfn(i),dfd(i),F(i),p(i));
        end
    end
    
end
