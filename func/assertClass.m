
function assertClass(var,u_class)
    %% ASSERTCLASS(var,u_class)
    % assert that variable [var] is one of classes {u_class}
    
    %% function
    if ~iscell(u_class), u_class = {u_class}; end
    b = any(cellfun(@(t)strcmpi(class(var),t),u_class));
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. variable has a wrong class',c);

end