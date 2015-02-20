
function varargout = getm_var(varargin)
    % [z,u] = getm_var(y,x1[,x2][,x3][...])
    
    [varargout{1:nargout}] = getm_func(@nanvar,varargin{:});
end