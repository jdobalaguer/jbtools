
function assertLength(varargin)
    %% ASSERTLENGTH(x1,x2,..)
    % assert that variables [x#] are not empty
    
    %% function
    b = cellfun(@isempty,varargin);
    b = ~b;
    b = all(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. one or more variables are are empty',c);
end
