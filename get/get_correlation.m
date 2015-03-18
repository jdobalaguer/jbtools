
function c = get_correlation(X,S)
    d = size(X,2);
    [u,n] = numbers(S);
    c = nan(d,d,n);
    for i = 1:n
        ii = (S == u(i));
        c(:,:,i) = corrcoef(X(ii,:));
    end
end