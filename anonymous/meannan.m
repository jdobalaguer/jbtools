
function r = meannan(x,d)
    %% r = MEANNAN(x[,d])
    % ratio of NaNs

    %% function
    if exist('d','var')
        r = mean(isnan(x),d);
    else
        r = mean(isnan(x(:)));
    end
end