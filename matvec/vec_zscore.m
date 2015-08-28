
function z = vec_zscore(varargin)
    %% [y] = VEC_ZSCORE(x[,s])
    % z-score matrix [y], independently for each combination of indices in {x}
    
    %% function
    
    % default
    y = varargin(1);
    x = varargin(2:end);
    
    % do
    z = vec_func(@f,y,x);
end

function z = f(y,~)
    s = [size(y{1},1),ones(1,ndims(y)-1)];
    m = repmat(nanmean(y{1},  1),s);
    v = repmat(nanstd (y{1},1,1),s);
    z = (y{1} - m) ./ v;
    z(v == 0) = 0;
end