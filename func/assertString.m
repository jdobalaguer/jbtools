
function assertString(varargin)
    %% ASSERTSTRING(x1,x2,..)
    % assert that variables [x#] are char/string
    
    %% function
    b = cellfun(@ischar,varargin);
    b = logical(b);
    b = all(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. one or more variables are not char/string',c);
end
