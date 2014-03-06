
function e = jb_index(v,i)
    assert(isvector(v),'jb_index: error. not a vector');
    e = nan;
    if i>0; e = v(i);       end
    if i<0; e = v(end+i);   end  
    if  ~i; e = v(end);     end
end
