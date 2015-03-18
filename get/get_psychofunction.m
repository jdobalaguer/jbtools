
function [y,x] = get_psychofunction(x,y,s,n)
    %% [y,x] = get_psychofunction(x,y,s,n)
    
    %% warnings
    
    %% function
    q = get_discrete(x,s,n);
    x = getm_mean(x,s,q);
    y = getm_mean(y,s,q);
    
end