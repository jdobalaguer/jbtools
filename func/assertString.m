
function assertString(var)
    %% ASSERTSTRING(var)
    % assert that variable [var] is a char/string
    
    %% function
    b = evalin('caller',sprintf('ischar(%s)',var));
    b = logical(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. "%s" is not a char/string',c,var);

end