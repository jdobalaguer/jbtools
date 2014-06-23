function h = entropy(p)
    assert(isvector(p),'entropy: error. p is not a vector');
    if(sum(p)==1), p = p/sum(p); end
    h = nansum(-p.*log(p));
end
