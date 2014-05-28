
function y = jb_precision(x,n)
    y = x;
    y = y .* (10  ^ n);
    y = round(y);
    y = y .* (0.1 ^ n);
end