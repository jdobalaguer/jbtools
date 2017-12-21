
function finder(file)
    %% FINDER(file)
    % open finder showing some file

    %% warnings

    %% function
    
    func_default('file',[pwd(),filesep]);
    if strcmp(file,'.'), file=pwd(); end
    
    if file_isdire(file) || exist(file,'dir')
        dirwith = file;
    else
        assertFile(file);
        dirwith = file_parts(file);
    end
    eval(sprintf('!open "%s"',dirwith));
end
