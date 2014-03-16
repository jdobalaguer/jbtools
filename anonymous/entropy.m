function h = entropy(p)
    assert(isvector(p),'entropy: error. p is not a vector');
    assert(sum(p)==1,'entropy: error. sum(p) != 1');
    h = nansum(-p.*log(p));
end
