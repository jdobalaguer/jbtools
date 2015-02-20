
function varargout = getm_min(varargin)
    % [z,u] = getm_min(y,x1[,x2][,x3][...])
    
    [varargout{1:nargout}] = getm_func(@nanmin,varargin{:});
end