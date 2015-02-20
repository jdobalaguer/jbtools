
function varargout = getm_sum(varargin)
    % [z,u] = getm_sum(y,x1[,x2][,x3][...])
    
    [varargout{1:nargout}] = getm_func(@nansum,varargin{:});
end