
function s = sizep(x,dim)
    %% s = SIZEP(x,dim)
    % return the size of x in dimensions dim
    
    %% warning
    
    %% function
    assert(nargin==2, 'sizep: error. nargin~=2');
    if ~exist('dim','var'), dim = 1:ndims(x); end
    s = size(x);
    s = s(dim);
    
end