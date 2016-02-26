
function x = inf2nan(x)
    %% x = INF2NAN(x)
    % replace all inf with nans
    
    %% function
    x(isinf(x(:))) = nan;
end
