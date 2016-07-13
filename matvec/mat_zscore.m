
function z = mat_zscore(x,d)
    %% z = MAT_ZSCORE(x[,d])
    % x : vector/matrix to z-score
    % d : dimension. if none specified, global z-scoring will be used
    % z : resulting z-score
    
    %% function
    
    % default
    func_default('d',[]);
    
    % global z-scoring
    if isempty(d)
        m = nanmean(x(:));
        s = nanstd (x(:),0);
    % dimension specific
    else
        r = ones(1,ndims(x));
        r(d) = size(x,d);
        m = repmat(nanmean(x,d),r);
        s = repmat(nanstd (x,0,d),r);
    end
        
    % z-score
    z = (x - m) ./ s;
    if ~s, z(:) = nan; end
end
