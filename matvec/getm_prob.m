
function varargout = getm_prob(varargin)
    %% [z,u] = GETM_PROB(x1[,x2][,x3][...])
    % like @getm_hist, but returns the probability across the first dimension

    %% function
    y = ones(size(varargin{1}));
    [varargout{1:nargout}] = getm_func(@sum,y,varargin{:});
    
    % probability normalisation
    s = size(varargout{1}); s(2:end) = 1;
    varargout{1} = varargout{1} ./ repmat(nansum(varargout{1},1),s);
end