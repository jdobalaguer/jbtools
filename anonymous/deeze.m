
function [m,e] = deeze(x,d)
    %% [m,e] = DEEZE(x[,d])
    % get the squeezed mean/ste of [x]
    % x : matrix. input values
    % d : vector. dimensions to remove
    
    %% function
    func_default('d',1);
    m = meeze(x,d);
    e = steeze(x,d);
end
