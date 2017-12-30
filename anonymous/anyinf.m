
function r = anyinf(x,d)
    %% r = ANYINF(x[,d])
    % any infinites

    %% warnings

    %% function
    if exist('d','var')
        r = any(isinf(x),d);
    else
        r = any(isinf(x(:)));
    end
end