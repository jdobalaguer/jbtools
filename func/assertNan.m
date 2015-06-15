
function assertNan(varargin)
    %% ASSERTNAN(x1,x2,..)
    % assert that variables [x#] dont have nans
    
    %% function
    b = all(~cellfun(@anynan,varargin));
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. one or more variables have a nan',c);

end