
function z = jb_emptyassign(x,y)
    if isempty(x),  z = y;
    else            z = x;
    end
end