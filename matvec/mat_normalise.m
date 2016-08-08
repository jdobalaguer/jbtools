
function z = mat_normalise(x,d)
    %% z = MAT_NORMALISE(x[,d])
    % x : vector/matrix to normalise, such that sum is 1
    % d : dimension. if none specified, global normalisation will be applied
    % z : resulting normalisation
    
    %% function
    
    % default
    func_default('d',[]);
    
    % global de-meaning
    if isempty(d)
        m = nansum(x(:));
    % dimension specific
    else
        r = ones(1,ndims(x));
        r(d) = size(x,d);
        m = repmat(nansum(x,d),r);
    end
        
    % de-mean
    z = (x ./ m);
end
