
function b = func_isnested(func)
    %% b = FUNC_ISNESTED(func)
    % check whether the function is nested
    
    %% function
    b = any(ismember(func2str(func),'\/'));
    
end