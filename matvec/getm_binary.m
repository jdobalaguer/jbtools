
function m = getm_binary(v,n)
    %% m = GETM_BINARY(v,n)
    % create a sparse logical matrix with indices for each value in [v]
    % v : a vector
    % n : number of columns
    % m : resulting logical matrix
    
    %% function
    
    % assert
    assertVector(v);
    assert(all(v==round(v)), 'getm_binary: error. only integers accepted');
    assert(all(v>0),         'getm_binary: error. only positive values');
    
    % default
    func_default('n',max(v));
    
    % create matrix
    l = numel(v);
    m = false(n,l);
    for i = 1:l, m(i,v(i)) = true; end
end
