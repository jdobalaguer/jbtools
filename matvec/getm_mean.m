
function varargout = getm_mean(varargin)
    %% [z,u] = GETM_MEAN(y,x1[,x2][,x3][...])
    
    %% function
    [varargout{1:nargout}] = getm_func(@nanmean,varargin{:});
end
