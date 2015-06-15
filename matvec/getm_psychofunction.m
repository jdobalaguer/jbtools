
function [y,x] = getm_psychofunction(x,y,s,n)
    %% [y,x] = getm_psychofunction(x,y,s,n)
    % get psychofunction matrix
    
    %% function
    q = vec_discrete(x,s,n);
    x = getm_mean(x,s,q);
    y = getm_mean(y,s,q);
    
end