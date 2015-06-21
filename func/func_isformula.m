
function b = func_isformula(func)
    %% b = FUNC_ISFORMULA(func)
    % check whether the function is a formula
    
    %% function
    b = any(ismember(func2str(func),'()'));
    
end