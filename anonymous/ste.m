
function vste = ste(m,d)
    %% vste = STE(m,d)
    % standard error (not tolerant to nans)
    
    %% function
    % default
    func_default('d',1);
    
    % values
    vstd = std(m,1,d);
    vsiz = size(m,d);
    vste = vstd./sqrt(vsiz);
return
