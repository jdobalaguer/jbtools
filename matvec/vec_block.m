
function y = vec_block(x)
    %% [y] = VEC_BLOCK(x)
    % calculate block how many times each block has been seen
    % e.g. >> x = [1,1,2,2,1,1,2,2,3,3,2,2,3,3,2,2];
    %      >> y = vec_block(x)
    %      y = 
    %          1 1 1 1 2 2 2 2 1 1 3 3 2 2 4 4
    
    %% function
    
    % assert
    assertVector(x);
    assertSize(x);
    
    % get rows
    x = mat2row(x);
    
    % see http://uk.mathworks.com/matlabcentral/answers/118828-how-to-count-the-number-of-consecutive-numbers-of-the-same-value-in-an-array
    i = find(diff(x));
    n = [i,numel(x)] - [0,i];
    v = x([1,i+1]);
    m = mat2row(sum(getm_dummy(v) .* cumsum(getm_dummy(v),1),2));
    
    c = arrayfun(@(n,m)repmat(m,1,n),n,m,'UniformOutput',false);
    y = cat(2,c{:});
    
    % reshape
    y = reshape(y,size(x));
end
