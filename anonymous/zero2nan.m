
function x = zero2nan(x)
    %% x = ZERO2NAN(x)
    % replace all zeros with nans
    
    %% function
    if islogical(x), x = double(x); end
    x(x(:)==0) = nan;
end
