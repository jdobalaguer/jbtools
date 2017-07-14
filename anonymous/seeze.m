
function y = seeze(x,d)
    %% y = seeze(x[,d])
    % get the sum, and squeeze through those dimensions
    % x : matrix. input values
    % d : vector. dimensions to remove
    
    %% function
    func_default('d',1);
    y = x;
    n = length(d);
    for i=1:n
        y = nansum(y,d(i));
    end
    y = mat_squeeze(y,d);
end