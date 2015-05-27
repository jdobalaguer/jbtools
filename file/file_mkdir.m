
function file_mkdir(path)
    %% FILE_MKDIR(path)
    % create a directory (recursively!)
    
    %% function
    if exist(path,'dir'); return; end
    path = file_rel2abs(path);
    path = file_nendsep(path);
    rootpath = fileparts(path);
    if ~exist(rootpath,'dir'), file_mkdir(rootpath); end
    if ~exist(path,'dir'),     mkdir(path);      end
end

