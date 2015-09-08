
function [m,e] = getm_dummy(v)
    %% m = GETM_DUMMY(v)
    % create a matrix with dummy variables
    
    %% function
    
    assertVector(v);
    v = mat2vec(v);
    [u,n] = numbers(v);
    s = numel(v);
    
    m = zeros(s,n);
    for i = 1:n
        ii = (v == u(i));
        m(ii,i) = 1;
    end
end
