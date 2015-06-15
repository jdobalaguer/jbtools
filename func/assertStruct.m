
function assertStruct(varargin)
    %% ASSERTSTRUCT(x1,x2,..)
    % assert that variables [x#] are structs
    
    %% function
    b = cellfun(@isstruct,varargin);
    b = logical(b);
    b = all(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. one or more variables are not structs',c);
end
