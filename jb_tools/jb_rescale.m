
function z = jb_rescale(x)
    maxx = max(x(:));
    minx = min(x(:));
    z = (x - minx) ./ (maxx - minx);
end
    