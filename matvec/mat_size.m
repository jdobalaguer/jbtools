
function s = mat_size(x,d)
    %% s = MAT_SIZE(x,d)
    % return the size of [x] for the dimensions [d]
    
    %% function
    func_default('d',[]);
    s = size(x);
    s = s(d);
end
