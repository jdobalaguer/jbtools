
function ii = jb_anyof(v,u)
    ii = false(size(v));
    for i=1:length(u)
        ii = ii | (v==u(i));
    end
end
