
function assertExist(var)
    %% assertExist(var)
    
    %% warnings
    %#ok<*EXIST>
    
    %% function
    b = evalin('caller',sprintf('exist(''%s'')',var));
    b = logical(b);
    c = caller();
    if isempty(c), c = 'assertExist'; end
    assert(b,'%s: error. "%s" doesnt exist',c,var);

end