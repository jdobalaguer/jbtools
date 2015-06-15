
function y = vec_displace(x,n,r,d)
    %% y = VEC_DISPLACE(x,n[,r][,d])
    % x : original vector
    % n : displacement
    % r : blocks index  (default single block)
    % d : fill-in value (default nan)
    % y : displaced vector
    
    %% defaults
    func_default('r',ones(size(x)));
    func_default('d',nan);
    
    %% assert
    assertVector(x,r);
    assertScalar(n,d);
    
    %% function
    y = vec_func(@displace,r);
    
    function t = displace(v)
        ii = (r == v);
        t = x(ii);
        if abs(n)<length(t),
            if n>0, t = [ repmat(d,[1,n]) , t(1:end-n)       ]; end
            if n<0, t = [ t(-n+1:end)     , repmat(d,[1,-n]) ]; end
        else
            t = repmat(d,size(t));
        end
    end
end
