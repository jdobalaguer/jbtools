
function assertMatrix(varargin)
    %% ASSERTMATRIX(x1,x2,..)
    % assert that variables [x#] are matrices
    
    %% function
    b = cellfun(@ismatrix,varargin);
    b = logical(b);
    b = all(b);
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. one or more variables are not matrices',c);
end
