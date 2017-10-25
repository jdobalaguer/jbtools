
function y = vec_tail(x,n)
    %% [y] = VEC_TAIL(x,n)
    % remove the first [n] elements from a vector [x]
    % x : vector
    % n : scalar (default 1)
    
    %% function
    
    % assert
    func_default('n',1);
    if n<0, n = size(x,1)+n; end
    s = size(x); s(1) = s(1)-n;
    y = reshape(x(n+1:end,:),s);
end
