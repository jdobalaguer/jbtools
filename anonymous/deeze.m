
function [m,e] = deeze(x,d)
    %% [m,e] = DEEZE(x,d)
    % get the squeezed mean/ste of [x]
    
    %% function
    func_default('d',1);
    m = meeze(x,d);
    e = steeze(x,d);
end
