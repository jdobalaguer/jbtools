
function assertFunc(varargin)
    %% assertFunc(f,x1,..)
    
    %% warnings
    
    %% function
    f = varargin{1};
    c = caller();
    if isempty(c), c = 'assertFunc'; end
    for i = 2:nargin
        assert(feval(f,varargin{i}),'%s: error. assertion failed',c);
    end
    
end