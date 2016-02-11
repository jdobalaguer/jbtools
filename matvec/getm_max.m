
function varargout = getm_max(varargin)
    %% [z,u] = GETM_MEAN(y,x1[,x2][,x3][...])
    
    %% function
    [varargout{1:nargout}] = getm_func(@nanmax,varargin{:});
end
