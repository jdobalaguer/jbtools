
function y = get_discrete(x,s,n)
    %% [y] = GET_DISCRETE(x,s,n)
    % discretize vector [x] in [n] bins, independently for each index in [s]
    % if [s] is empty, the discretization is processed globally
    
    %% warnings
    
    %% function
    
    % defaults
    if isempty(s), s = ones(size(x)); end
    
    % assert
    assert(isvector(x), 'get_discrete: error. x is not a vector.');
    assert(isvector(s), 'get_discrete: error. x is not a vector.');
    assert(isscalar(n), 'get_discrete: error. x is not a scalar.');
    assert(isscalar(n), 'get_discrete: error. x is not a scalar.');
    assertSize(x,s);
    
    % do
    y = nan(size(x));
    [u_s,n_s] = numbers(s);
    for i_s = 1:n_s
        ii_s = (s == u_s(i_s));
        l_s  = sum(ii_s);
        x_s  = x(ii_s);
        [~,ss_s] = sort(x_s(:));
        y_s = nan(1,l_s);
        y_s(ss_s) = ceil((1:l_s) * n / l_s);
        y(ii_s) = y_s;
    end
end
