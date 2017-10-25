
function y = vec_body(x,n)
    %% [y] = VEC_BODY(x,n)
    % remove the first and last [n] elements from a vector [x]
    % x : vector
    % n : scalar (default 1)
    
    %% function
    
    % assert
    func_default('n',1);
    s = size(x); s(1) = s(1)-2*n;
    y = reshape(x(n+1:end-n,:),s);
end
