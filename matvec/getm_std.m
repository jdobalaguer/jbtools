
function varargout = getm_std(varargin)
    %% [z,u] = GETM_STD(y,x1[,x2][,x3][...])
    
    %% function
    [varargout{1:nargout}] = getm_func(@(y)nanstd(y,[],1),varargin{:});
end
