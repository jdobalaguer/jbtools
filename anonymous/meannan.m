
function r = meannan(x,d)
    %% r = MEANNAN(x[,d])
    % ratio of NaNs

    %% warnings

    %% function
    if exist('d','var')
        r = mean(isnan(x),d);
    else
        r = mean(isnan(x(:)));
    end
end