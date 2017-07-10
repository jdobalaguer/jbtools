
function varargout = getm_ste(varargin)
    %% [z,u] = GETM_STE(y,x1[,x2][,x3][...])
    
    %% function
    [varargout{1:nargout}] = getm_func(@(y)nanste(y,1),varargin{:});
end
