
function vste = nanste(m,d)
    %% vste = NANSTE(m,d)
    % standard error (tolerant to nans)
    
    %% function
    % default
    func_default('d',1);
    
    % values
    vstd = nanstd(m,1,d);
    vsiz = sum(~isnan(m),d);
    vste = vstd./sqrt(vsiz);
return
