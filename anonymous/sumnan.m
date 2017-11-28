
function r = sumnan(x,d)
    %% r = SUMNAN(x[,d])
    % number of NaNs

    %% function
    if exist('d','var')
        r = sum(isnan(x),d);
    else
        r = sum(isnan(x(:)));
    end
end