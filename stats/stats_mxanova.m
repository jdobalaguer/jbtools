
function varargout = stats_mxanova(x,l)
    %% [h,p,F,tbl,stats,terms] = stats_mxanova(x[,l])
    % ANOVA for mixed designs (it automatically detects subject nested factors)
    % x : matrix. the data, with one dimension per factor
    %             the first dimension correspond must correspond to subjects
    %             with NaNs where missing data
    % l : cell of strings. one label per factor

    %% example
    % a{1} = [repmat(mat2vec(1:32),[4,1]);repmat(mat2vec(33:64),[4,1])];
    % a{2} = repmat(permat([1;2],[128,1]),[ 1,1]);
    % a{3} = repmat(permat([1;2],[ 64,1]),[ 2,1]);
    % a{4} = repmat(permat([1;2],[ 32,1]),[ 4,1]);
    % a = cat(2,a{:});
    % b = randn(size(a,1),1);
    % b(a(:,2)==1 & a(:,3)==1) = b(a(:,2)==1 & a(:,3)==1) - 1;
    % b(a(:,2)==2 & a(:,3)==1) = b(a(:,2)==2 & a(:,3)==1) + 1;
    % b(a(:,2)==1 & a(:,3)==2) = b(a(:,2)==1 & a(:,3)==2) + 1;
    % b(a(:,2)==2 & a(:,3)==2) = b(a(:,2)==2 & a(:,3)==2) - 1;
    % x = getm_mean(b,a(:,1),a(:,2),a(:,3),a(:,4));
    % >> stats_mxanova(x);

    %% function
    varargout = {};
    
    % default
    n = ndims(x);
    func_default('l',num2cell(char('A'+(0:n-2))));
    
    % assert
    if ismember('Subject',strtrim(l)), func_error('"Subject" is not a valid label'); end
    
    % find random factors
    d = [];
    for i = 2:n
        ii = num2cell(ones(1,n));
        ii{1} = 1:size(x,1);
        ii{i} = 1:size(x,i);
        if all(sum(~isnan(squeeze(x(ii{:}))),2)==1)
            d(end+1) = i;
        end
    end
    clear i ii;
    func_assert(~isempty(d),'error. [x] must include one between-subjects variable');
    
    % define grid
    s = size(x);
    t = arrayfun(@(t)1:t,s,'UniformOutput',false);
    [t{1:n}] = ndgrid(t{:});
    t = cellfun(@mat2vec,t,'UniformOutput',false);
    t = cat(2,t{1:end});
    
    % index
    ii = ~isnan(x(:));
    t = t(ii,:);
    x = x(ii);
    
    % labels
    l = [{'Subject'},l];
    
    % ANOVA
    nested = zeros(n); nested(1,d) = 1;
    [p,tbl,stats,terms] = anovan(x,t,'display','off','varnames',l,...
                                     'random',1,'nested',nested,...
                                     'model','full');
                                 
    % effects
    effects = tbl(2:end-2,1);
    
    % return
    h   = (p < 0.05);
    F   = cell2mat(tbl(2:end-2,6));
    dfd = nan(size(p));
    dfn = cell2mat(tbl(2:end-2,3));
    
    % print
    if ~nargout
        for i = 1:numel(h)
            fprintf('Effect %02d: %-18s F(%3.2f,%3.2f)=%4.3f,\tp=%4.3f \n',i,effects{i},dfn(i),dfd(i),F(i),p(i));
        end
    else
        varargout = {h,p,F,tbl,stats,terms};
    end
end
