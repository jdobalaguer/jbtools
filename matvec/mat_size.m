
function s = mat_size(x,d)
    %% s = MAT_SIZE(x,d)
    % return the size of [x] for the dimensions [d]
    
    %% function
    if ~exist('d','var'), d = 1:mat_dims(x); end % but not if it's empty
    s = size(x);
    s(end+1:max(d)) = 1;
    s = s(d);
end
