
function p = softmax(l,d,b)
    %% p = SOFTMAX(l,d,b)
    % softmax probability
    % l = logits
    % d = dimension
    % b = beta (inv temperature)
    % p = probability
    
    %% function
    func_default('d',1);
    func_default('b',1);
    
    if (b == +inf)
        p = mat_normalise(double(bsxfun(@eq,l,max(l,[],2))),2);
    else
        x = ones(1,ndims(l));
        x(d) = size(l,d);
        m = l - repmat(max(l,[],d),x);
        q = exp(b*m);
        s = repmat(nansum(q,d),x);
        p = q ./ s;
        p(isnan(p(:))) = 0;
    end
end
