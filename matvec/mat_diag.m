
function m = mat_diag(v,s)
    %% m = MAT_DIAG(v,s)
    % create a matrix of size [s] with values [v] in the diagonal
    
    %% function
    
    % default
    if isscalar(s), s = [s,s]; end
    assertVector(v);
    n = length(v);
    d = length(s);
        
    % assert
    assert(all(n <= s),'mat_diag: error. vector [v] longer than size [s]');
    m = zeros(s);
    for i = 1:n
        ii = repmat({i},[1,d]);
        m(ii{:}) = v(i);
    end
end