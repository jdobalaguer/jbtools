
function b = isrelative(path)
    %% b = ISRELATIVE(path)
    % whether the path is relative or not

    %% warnings
    
    %% function
    assertUnix();
    assert(ischar(path), 'isrelative: error. path is not a string');
    b = (path(1) ~= '/');
end