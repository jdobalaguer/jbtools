
function m = jb_binaryindex(v,n)
    assert(isvector(v),         'jb_binaryindex: error. v is not a vector');
    assert(all(v==round(v)),    'jb_binaryindex: error. only integers accepted');
    assert(all(v >0),           'jb_binaryindex: error. only positive values');
    if ~exist('n','var'), n = max(v); end
    l = numel(v);
    m = false(n,l);
    for i = 1:l, m(v(i),i) = true; end
end