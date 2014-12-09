
function r = anynan(x,d)
    if exist('d','var')
        r = any(isnan(x),d);
    else
        r = any(isnan(x(:)));
    end
end