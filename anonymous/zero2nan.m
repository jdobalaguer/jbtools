
function x = zero2nan(x)
    %% x = ZERO2NAN(x)
    % replace all zeros with nans
    
    %% function
    x(x(:)==0) = nan;
end
