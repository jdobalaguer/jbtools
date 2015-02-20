
function varargout = getm_ste(varargin)
    % [z,u] = getm_ste(y,x1[,x2][,x3][...])
    
    [varargout{1:nargout}] = getm_func(@nanste,varargin{:});
end