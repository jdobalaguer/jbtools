
function func_warning(condition,varargin)
    %% FUNC_WARNING(text)
    % assert and throw a formatted error
    % text : message
    
    %% note
    % see also func_error, func_assert
    % this can be improved. currently, the error is always thrown from func_assert()
    
    %% function
    if ~condition
        warning('%s : %s',func_caller(),sprintf(varargin{:}));
    end
end
