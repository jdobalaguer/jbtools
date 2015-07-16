
function b = func_isnested(func)
    %% b = FUNC_ISNESTED(func)
    % check whether the function is nested
    
    %% function
    b = ~func_isformula(func) && any(ismember(func2str(func),'\/'));
end
