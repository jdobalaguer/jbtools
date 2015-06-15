
function y = get_count(varargin)
    %% [y] = GET_COUNT(v1,v2...)
    % count how many times each value has been shown previously
    
    %% warnings
    
    %% function
    
    % assert
    for i = 1:length(varargin)
        assert(isvector(varargin{i}),'get_count: error. v%d is not a vector.',i);
    end
    assertSize(varargin{:});
    
    % vector
    vector = cell2mat(cellfun(@mat2vec,varargin,'UniformOutput',false));
    s = size(vector);
    
    % get rows
    z = get_rows(varargin{:});
    [u,n] = numbers(z);
    
    % do
    y = nan(size(varargin{1}));
    for i = 1:n
        ii = (z == u(i));
        y(ii) = 1:sum(ii);
    end
end
