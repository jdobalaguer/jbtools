
function varargout = getm_max(varargin)
    %% [z,u] = GETM_MAX(y,x1[,x2][,x3][...])
    
    %% function
    [varargout{1:nargout}] = getm_func(@auxiliar,varargin{:});
end

function z = auxiliar(y)
    z = nanmax(y,[],1);
    if isempty(z), z = nan; end
end
