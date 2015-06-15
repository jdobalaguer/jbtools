
function assertCell(varargin)
    %% ASSERTCELL(x1,x2,..)
    % assert that variables [x#] are cell
    
    %% function
    b = cellfun(@iscell,varargin);
    b = logical(b);
    b = all(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. one or more variables are not cell',c);
end
