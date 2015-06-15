
function varargout = getm_hist(varargin)
    % [z,u] = getm_hist(x1[,x2][,x3][...])
    
    y = ones(size(varargin{1}));
    [varargout{1:nargout}] = getm_func(@sum,y,varargin{:});
end