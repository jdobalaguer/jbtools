
function [y,q] = jb_discretize(x,n)
    [~,ii] = sort(x(:));
    l = linspace(0,numel(x),n+1);
    y = nan(size(x));
    q = nan(1,n+1);
    for i = 1:n
        jj = ceil(l(i))+1 : ceil(l(i+1));
        y(ii(jj)) = i;
        q(i) = x(ii(jj(1)));
    end
    q(n+1) = max(x(:));
    
end