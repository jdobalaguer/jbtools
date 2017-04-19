
function y = steeze(x,d)
    %% y = steeze(x,d)
    % get the standard error, and squeeze across those dimensions
    % x : matrix. input values
    % d : vector. dimensions to remove
    
    %% function
    func_default('d',1);
    y = x;
    n = length(d);
    for i=1:n
        y = nanste(y,d(i));
    end
    y = mat_squeeze(y,d);
end
