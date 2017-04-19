
function y = meeze(x,d)
    %% y = meeze(x[,d])
    % get the mean, and squeeze through those dimensions
    % x : matrix. input values
    % d : vector. dimensions to remove
    
    %% function
    func_default('d',1);
    y = x;
    n = length(d);
    for i=1:n
        y = nanmean(y,d(i));
    end
    y = mat_squeeze(y,d);
end