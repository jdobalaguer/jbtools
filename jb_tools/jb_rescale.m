
function z = jb_rescale(x,r)
    %% z = JB_RESCALE(x[,r])
    % rescale a vector/matrix within range r
    % x : vector/matrix with input values
    % r : vector [min,max] (default [0,1])
    % z : resulting vector/matrix
    
    %% function
    func_default('r',[0,1]);
    maxx = max(x(:));
    minx = min(x(:));
    z = (x - minx) ./ (maxx - minx);
    z = r(1) + (diff(r) .* z);
end
