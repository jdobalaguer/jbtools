
function assertFunc(varargin)
    %% ASSERTFUNC(f,x1,..)
    % assert variables with a custom function
    % e.g. assertFunc(@length,[])
    
    %% function
    f = varargin{1};
    c = func_caller();
    func_default('c',func_caller(0));
    for i = 2:nargin
        assert(logical(feval(f,varargin{i})),'%s: error. assertion failed',c);
    end
    
end