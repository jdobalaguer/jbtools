
function b = isabsolute(path)
    %% b = ISABSOLUTE(path)
    % whether the path is absolute or not

    %% warnings
    
    %% function
    assertUnix();
    b = ~isrelative(path);
end