
function y = vec_count(varargin)
    %% [y] = VEC_COUNT(v1,v2...)
    % count how many times each condition has been shown previously
    
    %% function
    
    % assert
    assertVector(varargin{:});
    assertSize(varargin{:});
    
    % get rows
    z = vec_rows(varargin{:});
    [u,n] = numbers(z);
    
    % do
    y = nan(size(varargin{1}));
    for i = 1:n
        ii = (z == u(i));
        y(ii) = 1:sum(ii);
    end
end
