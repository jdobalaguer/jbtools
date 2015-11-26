
function s = mat_size(x,d)
    %% s = MAT_SIZE(x,d)
    % return the size of [x] for the dimensions [d]
    
    %% function
    if ~exist('d','var'), d = 1:ndims(x); end % but not if it's empty
    s = size(x);
    s = s(d);
end
