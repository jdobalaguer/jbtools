
function varargout = getm_hist(varargin)
    %% [z,u] = GETM_HIST(x1[,x2][,x3][...])
    % returns the histogram of combinations of x1, x2, ..
    
    %% function
    y = ones(size(varargin{1}));
    [varargout{1:nargout}] = getm_func(@sum,y,varargin{:});
end