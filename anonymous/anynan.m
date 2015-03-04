
function r = anynan(x,d)
    %% r = ANYNAN(x[,d])
    % any NaNs

    %% warnings

    %% function
    if exist('d','var')
        r = any(isnan(x),d);
    else
        r = any(isnan(x(:)));
    end
end