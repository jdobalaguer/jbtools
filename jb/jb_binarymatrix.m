
function m = jb_binarymatrix(v)
    assert(isvector(v),         'jb_binarymatrix: error. v is not a vector');
    assert(all(v==round(v)),    'jb_binarymatrix: error. only integers accepted');
    assert(all(v >0),           'jb_binarymatrix: error. only positive values');
    n = max(v);
    l = numel(v);
    m = false(n,l);
    for i = 1:l, m(v(i),i) = true; end
end