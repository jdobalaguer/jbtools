
function d = mat_dims(x)
    %% d = MAT_DIMS(x)
    % return the dimensions [d] of [x]
    
    %% function
    d = ndims(x);
    if iscolumn(x), d = 1; end
end
