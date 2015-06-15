
function h = entropy(p)
    assertVector(p);
    if(sum(p)==1), p = p/sum(p); end
    h = nansum(-p.*log(p));
end
