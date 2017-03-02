
function y = vec_head(x,n)
    %% [y] = VEC_HEAD(x,n)
    % keep the first [n] elements of a vector [x]
    % x : vector
    % n : scalar (default 1)
    
    %% function
    
    % assert
    func_default('n',1);
    y = x(1:n);
end
