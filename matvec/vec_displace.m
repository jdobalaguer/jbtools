
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
    y = vec_func(@displace,{x},{r});
    
    function v = displace(y,~)
        v = y{1};
        if abs(n)<length(v),
            if n>0, v = [ repmat(d,[n,1]) ; v(1:end-n)       ]; end
            if n<0, v = [ v(-n+1:end)     ; repmat(d,[-n,1]) ]; end
        else
            v = repmat(d,size(v));
        end
    end
end
