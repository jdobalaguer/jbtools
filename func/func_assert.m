
function func_assert(condition,varargin)
    %% FUNC_ASSERT(text)
    % assert and throw a formatted error
    % text : message
    
    %% note
    % see also func_error, func_warning
    % this can be improved. currently, the error is always thrown from func_assert()
    
    %% function
    if ~condition
        error('%s : %s',func_caller(),sprintf(varargin{:}));
    end
end
