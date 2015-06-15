
function m = getm_correlation(X,S)
    % m = GETM_CORRELATION(x,s)
    % get a matrix of correlations for each index in s
    % x : matrix of size [#samples,#regressor]
    % s : vector of size [#samples]
    % m : matrix of correlations of size [#regressor,#regressor,#indices]
    
    %% function
    d = size(X,2);
    [u,n] = numbers(S);
    m = nan(d,d,n);
    for i = 1:n
        ii = (S == u(i));
        m(:,:,i) = corrcoef(X(ii,:));
    end
end
