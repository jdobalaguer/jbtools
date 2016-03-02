
function posterior = bayes_prod(varargin)
    %% y = bayes_prod(x1[,x2][,..])
    % multiply inputs and normalize so that it sums one
    % this makes use of multiple tricks to avoid float-precision issues
    
    %% function
    
    % input
    x = varargin;
    
    % assert
    assertSize(x{:});
    assertNan(x{:});
    assertFunc(@(x)all(x(:)>=0),x{:});
    assertFunc(@(x)all(x(:)<=1),x{:});
    
    % variables
    s = size(x{1});
    n = length(s);
    
    % get logarithms
    x = cellfun(@log2,x,'UniformOutput',false);
    
    % rescale
    x = cellfun(@(x) x - max(x(:)),x,'UniformOutput',false);
    
    % concatenate
    x = cat(n+1,x{:});
    x = sum(x,n+1);
    x = x - max(x(:));
    
    % probability
    x = pow2(x);
    posterior = x ./ sum(x(:));
end
