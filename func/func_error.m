
function func_error(text)
    %% FUNC_ERROR(text)
    % throw a formatted error
    % text : message
    
    %% note
    % this can be improved. currently, the error is always thrown from func_error()
    
    %% function
    error('%s : %s',func_caller(),text);
end