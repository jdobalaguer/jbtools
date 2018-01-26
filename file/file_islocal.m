
function b = file_islocal(path)
    %% b = FILE_ISLOCAL(path)
    % whether the path is absolute or not

    %% function
    b = strcmp(path, file_2local(path));
end
