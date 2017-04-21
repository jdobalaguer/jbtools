
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
    func_assert(~ismember('Subject',strtrim(l)),'"Subject" is not a valid label');
    
    % find random factors
    d = [];
    for i = 2:n
        ii = num2cell(ones(1,n));
        ii{1} = 1:size(x,1);
        ii{i} = 1:size(x,i);
        if any(sum(~isnan(squeeze(x(ii{:}))),2)==1)
            d(end+1) = i;
        end
    end
    
    % assert mixed design matrix
    ii = num2cell(ones(n,1));
    ii([1,d]) = arrayfun(@(s)1:s,mat_size(x,[1,d]),'UniformOutput',false);
    z = ~isnan(x(ii{:}));
    func_assert(all(sum(z(:,:),2)==1),'[x] does not conform to a mixed design');
    clear i ii z;
    
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
    ii_random = find(strcmp(tbl(2:end-2,8),'random'));
    ii_fixed  = find(strcmp(tbl(2:end-2,8),'fixed'));
    h   = (p < 0.05);
    F   = cell2mat(tbl(2:end-2,6));
    dfd = repmat(unique(cell2mat(tbl(ii_random+1,3))),size(p));
    dfn = repmat(unique(cell2mat(tbl(ii_fixed+1,3))),size(p));
    dfd(ii_random) = 0;
    dfn(ii_random) = 0;
    
    % print
    if ~nargout
        for i = 1:numel(h)
            fprintf('Effect %02d: %-18s F(%3.0f,%3.0f) = %7.3f,\tp=%7.3f \n',i,effects{i},dfn(i),dfd(i),F(i),p(i));
        end
    else
        varargout = {h,p,F,tbl,stats,terms};
    end
end
