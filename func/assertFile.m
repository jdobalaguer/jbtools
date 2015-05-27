
function assertFile(file)
    %% ASSERTFILE(file)
    % assert that file exists
    
    %% function
    b = (exist(file,'file') == 2); % but this doesn't check that the file is actually here
    c = func_caller();
    func_default('c',func_caller(0));
    assert(b,'%s: error. "%s" doesnt exist',c,file);

end
