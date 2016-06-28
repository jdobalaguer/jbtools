
function i = randsel(p,d)
    %% i = RANDSEL(p,d)
    % select random samples [i] from a matrix of probabilities [p]
    % along a certain dimension [d]
    % p : matrix, probabilities
    % d : scalar, dimension (default 1)
    % i : matrix, index of the random samples
    
    %% function
    
    % default
    func_default('d',1);
    
    % sizes
    n = ndims(p);
    s = size(p);   s(d) = 1;
    z = ones(1,n); z(d) = size(p,d);
    
    % values
    v = repmat(rand(s) .* sum(p,d),z);
    c = cumsum(p,d);
    
    % meshgrid
    m = arrayfun(@(sp)1:sp,size(p),'unif',0);
    if n>1, m([1,2]) = m([2,1]); end % meshgrid weird behaviour
    [m{1:n}] = meshgrid(m{:});
    if n>1, m([1,2]) = m([2,1]); end % meshgrid weird behaviour
    m = m{d};
    
    % selection
    i = max((v > c) .* m, [], d);
end
