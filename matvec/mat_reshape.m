
function m = mat_reshape(m,s)
    %% m = MAT_RESHAPE(m,s)
    % reshape. works with s scalar
    
    %% function
    if isscalar(s)
        s(2) = 1;
    end
    m = reshape(m,s);
end
