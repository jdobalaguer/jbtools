
function r = meaninf(x,d)
    %% r = MEANINF(x[,d])
    % ratio of INFs

    %% function
    if exist('d','var')
        r = mean(isinf(x),d);
    else
        r = mean(isinf(x(:)));
    end
end