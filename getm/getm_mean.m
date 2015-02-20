
function varargout = getm_mean(varargin)
    % [z,u] = getm_mean(y,x1[,x2][,x3][...])
    
    [varargout{1:nargout}] = getm_func(@nanmean,varargin{:});
end