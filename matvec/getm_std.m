
function varargout = getm_std(varargin)
    % [z,u] = getm_std(y,x1[,x2][,x3][...])
    
    [varargout{1:nargout}] = getm_func(@nanstd,varargin{:});
end