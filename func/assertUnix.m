
function assertUnix()
    %% ASSERTUNIX()
    % assert that the system is unix-friendly

    %% function
    c = func_caller();
    func_default('c',func_caller(0));
    assert(isunix(), '%s: error. This is not a Unix/Linux system',c);
end