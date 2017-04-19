
function varargout = stats_ubanova(x,l)
    %% [h,p,F,tbl,stats,terms] = stats_ubanova(x[,l])
    % Unbalanced ANOVA
    % x : matrix. the data, with one dimension per factor
    %             the first dimension correspond must correspond to subjects
    %             with NaNs where missing data
    % l : cell of strings. one label per factor
    
    %% example
    % a{1} = mat2vec(1:256);
    % a{2} = repmat(permat([1;2],[128,1]),[ 1,1]);
    % a{3} = repmat(permat([1;2],[ 64,1]),[ 2,1]);
    % a{4} = repmat(permat([1;2],[ 32,1]),[ 4,1]);
    % a = cat(2,a{:});
    % b = randn(size(a,1),1);
    % b(a(:,3)==1 & a(:,4)==1) = b(a(:,3)==1 & a(:,4)==1) - 1;
    % b(a(:,3)==2 & a(:,4)==1) = b(a(:,3)==2 & a(:,4)==1) + 1;
    % b(a(:,3)==1 & a(:,4)==2) = b(a(:,3)==1 & a(:,4)==2) + 1;
    % b(a(:,3)==2 & a(:,4)==2) = b(a(:,3)==2 & a(:,4)==2) - 1;
    % x = getm_mean(b,a(:,1),a(:,2),a(:,3),a(:,4));
    % >> stats_ubanova(x);
    
    %% function
    varargout = {};
    
    % assert
    func_assert(all(sum(~isnan(x(:,:)),2)==1),'error. [x] does not correspond to a between-group design.');
    
    % default
    n = ndims(x);
    func_default('l',num2cell(char('A'+(0:n-2))));
    
    % define grid
    s = size(x);
    t = arrayfun(@(n)1:n,s,'UniformOutput',false);
    [t{1:n}] = ndgrid(t{:});
    t = cellfun(@mat2vec,t,'UniformOutput',false);
    t = cat(2,t{2:end});
    
    % index
    ii = ~isnan(x(:));
    t = t(ii,:);
    x = x(ii);
    
    % ANOVA
    [p,tbl,stats,terms] = anovan(x,t,'display','off','varnames',l,'model','full');

    % effects
    effects = tbl(2:end-2,1);
    
    % return
    h   = (p < 0.05);
    F   = cell2mat(tbl(2:end-2,6));
    dfd = zeros(size(p));
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
