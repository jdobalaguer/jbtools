
function S = nanprod(varargin)
    %% S = nanprod(X)
    % See also prod
    
    %% warnings
    
    %% function
    varargin{1}(isnan(varargin{1})) = 1;
    S = prod(varargin{:});
    

end
    
