
function z = mat_demean(x,d)
    %% z = MAT_DEMEAN(x[,d])
    % x : vector/matrix to de-mean
    % d : dimension. if none specified, global de-meaning will be used
    % z : resulting de-mean
    
    %% function
    
    % default
    func_default('d',[]);
    
    % global de-meaning
    if isempty(d)
        m = nanmean(x(:));
    % dimension specific
    else
        r = ones(1,ndims(x));
        r(d) = size(x,d);
        m = repmat(nanmean(x,d),r);
    end
        
    % de-mean
    z = (x - m);
end
