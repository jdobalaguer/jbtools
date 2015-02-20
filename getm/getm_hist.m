
function varargout = getm_hist(varargin)
    % [z,u] = getm_mean(x1[,x2][,x3][...])
    
    varargin = [{ones(size(varargin{1}))},varargin];
    [varargout{1:nargout}] = getm_func(@sum,varargin{:});
end