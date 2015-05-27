
function b = file_isabs(path)
    %% b = FILE_ISABS(path)
    % whether the path is absolute or not

    %% function
    assertUnix();
    assertString(path, 'file_isabsolute: error. path is not a string');
    b = (path(1) ~= '/');
end
