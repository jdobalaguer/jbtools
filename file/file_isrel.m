
function b = file_isrel(path)
    %% b = FILE_ISREL(path)
    % whether the path is relative or not

    %% function
    assertUnix();
    assertString('path');
    b = (path(1) ~= '/');
end
