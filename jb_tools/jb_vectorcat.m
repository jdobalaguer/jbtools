
function z = jb_vectorcat(x,y)
    %% jb_vectorcat(x,y)
    
    %% warnings
    
    %% function
    
    if isempty(y), z = x; return; end
    if isempty(x), z = y; return; end
    assert(isvector(x),'jb_vectorcat: error. [x] is not a vector');
    assert(isvector(y),'jb_vectorcat: error. [y] is not a vector');
    
    z = [];
    if iscolumn(x) && iscolumn(y), z = [x;y]; end
    if isrow(x)    && isrow(y),    z = [x,y]; end
    assert(~isempty(z),'jb_vectorcat: error. [x] and [y] must both be consistently columns/rows');
    
end