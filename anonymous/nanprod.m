
function s = nanprod(varargin)
    %% s = NANPROD(x[,d])
    % See also prod
    
    %% function
    varargin{1}(isnan(varargin{1})) = 1;
    s = prod(varargin{:});
end
