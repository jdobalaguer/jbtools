
function y = vec_tail(x,n)
    %% [y] = VEC_TAIL(x,n)
    % remove the first [n] elements from a vector [x]
    % x : vector
    % n : scalar (default 1)
    
    %% function
    
    % assert
    func_default('n',1);
    if n<0, n = numel(x)+n; end
    y = x(n+1:end);
end
