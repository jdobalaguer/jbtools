
function y = mat_replicate(x,s)
    %% y = mat_replicate(x,s)
    % x : input vector/matrix/tensor
    % s : size of output [y]
    % y : output vector

    %% function
    
    % size
    q = size(x);
    q(end+1:length(s)) = 1;
    r = ceil(s./q);
    
    % create vectors
    y = repmat(x,r);
    
    % trim dimensions
    ii = arrayfun(@(i)1:s(i), 1:ndims(y), 'UniformOutput', false);
    y = y(ii{:});
end
