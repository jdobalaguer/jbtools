
function z = vec_shuffle(varargin)
    %% [z] = VEC_DEMEAN(y[,x1][,x2])
    % de-mean matrix [y], independently for each combination of indices in {x}
    
    %% function
    
    % default
    y = varargin(1);
    x = varargin(2:end);
    
    % do
    z = vec_func(@f,y,x);
end

function z = f(y,~)
    s = [size(y{1},1),ones(1,ndims(y)-1)];
    z = shuffle(y{1});
end