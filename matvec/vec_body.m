
function y = vec_body(x,n)
    %% [y] = VEC_BODY(x,n)
    % remove the first and last [n] elements from a vector [x]
    % x : vector
    % n : scalar (default 1)
    
    %% function
    
    % assert
    func_default('n',1);
    y = x(n+1:end-n);
end
