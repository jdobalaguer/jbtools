
function varargout = getm_prod(varargin)
    % [z,u] = getm_prod(y,x1[,x2][,x3][...])
    
    [varargout{1:nargout}] = getm_func(@nanprod,varargin{:});
end