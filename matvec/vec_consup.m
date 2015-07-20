
function y = vec_consup(varargin)
    %% [y] = VEC_CONSUP(v1,v2...)
    % count how many consecutive times a condition has been shown previously
    
    %% function
    
    % assert
    assertVector(varargin{:});
    assertSize(varargin{:});
    
    % get rows
    x = vec_rows(varargin{:});
    x = mat2row(x);
    
    % see http://uk.mathworks.com/matlabcentral/answers/118828-how-to-count-the-number-of-consecutive-numbers-of-the-same-value-in-an-array
    i = find(diff(x));
    n = [i,numel(x)] - [0,i];
    c = arrayfun(@(X)1:X,n,'UniformOutput',false);
    y = cat(2,c{:});
    
    % reshape
    y = reshape(y,size(varargin{1}));
end
