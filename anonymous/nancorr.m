
function [rho,pval] = nancorr(x,y,varargin)
    %% [rho,pval] = NANCORR(x,y,varargin)
    % like corr, but robust to NaNs
    % see also corr

    %%  function
    
    % default
    if isvector(x), x = mat2vec(x); end
    func_default('y',x);
    
    % numbers
    n_x = size(x,2);
    n_y = size(y,2);
    
    % compute correlations
    [rho,pval] = deal(nan(n_x,n_y));
    for i_x = 1:n_x
    for i_y = 1:n_y
        
        ii = ~isnan(x(:,i_x)) & ~isnan(y(:,i_y));
        [rho(i_x,i_y),pval(i_x,i_y)] = corr(x(ii,i_x),y(ii,i_y),varargin{:});
        
    end
    end
    
    % fix @corr weirdness
    % the p-value is 0 for corr(x,x)
    % the p-value is 1 for corr(x)
    if isequalwithequalnans(y,x)
        pval = pval + diag(ones([1,size(x,2)]));
    end
    
    
end