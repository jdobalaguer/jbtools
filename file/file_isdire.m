
function b = file_isdire(path)
    %% b = FILE_ISDIRE(path)
    % whether the path is a directory (i.e. finished with a filesep)

    %% function
    assertString('path');
    b = strcmp(path,file_endsep(path));
end
