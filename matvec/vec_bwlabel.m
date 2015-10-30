
function y = vec_bwlabel(x)
    %% [y] = VEC_BWLABEL(x)
    % similar to bwlabel, vec_rows and vec_block
    % give a different label for each block
    % e.g. >> x = [1,1,2,2,1,1,2,2,3,3,2,2,3,3,2,2];
    %      >> y = vec_bwlabel(x)
    %      y = 
    %          1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8
    
    %% function
    
    % assert
    assertVector(x);
    assertSize(x);
    
    % get rows
    z = mat2row(x);
    
    % see http://uk.mathworks.com/matlabcentral/answers/118828-how-to-count-the-number-of-consecutive-numbers-of-the-same-value-in-an-array
    i = find(diff(z));
    n = [i,numel(z)] - [0,i];
    v = z([1,i+1]);
    m = 1:length(n);
    
    c = arrayfun(@(n,m)repmat(m,1,n),n,m,'UniformOutput',false);
    y = cat(2,c{:});
    
    % reshape
    y = reshape(y,size(x));
end
