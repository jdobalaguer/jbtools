
function c = fun2cell(varargin)
    %% varargout = FUN2CELL(f,n,varargin)
    %  catches all output inside a cell
    
    %% warning
    
    %% function
    f = varargin{1};
    n = varargin{2};
    if isempty(n), n = nargout(f); end
    i = varargin(3:end);
    [c{1:n}] = f(i{:});
end