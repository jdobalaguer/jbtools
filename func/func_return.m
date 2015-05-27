
function c = func_return(varargin)
    %% varargout = FUNC_RETURN(f,n,varargin)
    %  catches all output inside a cell
    
    %% function
    f = varargin{1};
    n = varargin{2};
    if isempty(n), n = nargout(f); end
    i = varargin(3:end);
    [c{1:n}] = f(i{:});
    
end