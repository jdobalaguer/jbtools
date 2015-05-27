
function assertScalar(var)
    %% ASSERTSCALAR(var)
    % assert that variable [var] is a scalar
    
    %% function
    b = evalin('caller',sprintf('isscalar(%s)',var));
    b = logical(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. "%s" is not a scalar',c,var);

end