
function assertVector(varargin)
    %% ASSERTVECTOR(x1,x2,..)
    % assert that variables [x#] are vectors
    
    %% function
    b = cellfun(@isvector,varargin);
    b = logical(b);
    b = all(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. one or more variables are not vectors',c);
end
