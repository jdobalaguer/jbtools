
function func = func_handle(file)
    %% func = FUNC_HANDLE(file)
    % get the handle of a function file
    
    %% function
    here = pwd();
    [path,name] = fileparts(file);
    cd(path);
    func = str2func(name);
    cd(here);
end
