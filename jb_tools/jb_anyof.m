
function ii = jb_anyof(v,u)
    ii = false(size(v));
    for i=1:length(u)
        if iscellstr(v),    ii = ii | streq(v,u{i});
        else                ii = ii | (v==u(i));
        end
    end
end
