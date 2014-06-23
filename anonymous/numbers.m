
function [u,n,h] = numbers(x)
    u = unique(x);
    n = length(u);
    if nargout==3
        h = nan(1,n);
        for i=1:n, h(i) = sum(x==u(i)); end
    end
end