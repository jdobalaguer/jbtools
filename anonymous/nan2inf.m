
function x = nan2inf(x)
    %% x = NAN2INF(x)
    % replace all inf with nans
    
    %% function
    x(isnan(x(:))) = inf;
end
