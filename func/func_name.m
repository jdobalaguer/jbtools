
function var = func_name(i)
    %% name = func_name(i)
    % return the name of the variable passed as an argument
    % it strongly relies on "inputname"
    % i   : index of the argument
    % var : name of the variable passed (empty of no variable defined)
    
    %% function
    var = evalin('caller',sprintf('inputname(%d)',i));
end
