
function n = mat_ndims(x)
    %% n = MAT_NDIMS(x)
    % return the number of dimensions of [x]
    
    %% function
    if isempty(x),      n = 0;
    elseif isscalar(x), n = 1;
    else,               n = ndims(x);
    end
end
