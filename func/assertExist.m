
function assertExist(var)
    %% ASSERTEXIST(var)
    % assert that variable exists
    
    %% function
    b = evalin('caller',sprintf('exist(''%s'')',var));
    b = logical(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. "%s" doesnt exist',c,var);

end