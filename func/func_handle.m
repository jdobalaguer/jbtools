
function func = func_handle(file)
    %% func = FUNC_HANDLE(file)
    % get the handle of a function file
    
    %% function
    here = pwd();
    [path,name] = fileparts(file);
    if ~isempty(path), cd(path); end
    func = str2func(name);
    cd(here);
end
