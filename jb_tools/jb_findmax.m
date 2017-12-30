
function [f,v] = jb_findmax(m)
    %% [f,v] = JB_FINDMAX(m)
    % finds the indices [f(i,:)] of the global maxima in matrix [m]
    
    %% warning
    
    %% function
    [f,v] = jb_findmin(-m);
end