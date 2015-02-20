
function varargout = getm_max(varargin)
    % [z,u] = getm_max(y,x1[,x2][,x3][...])
    
    [varargout{1:nargout}] = getm_func(@nanmax,varargin{:});
end