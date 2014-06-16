
function r = ranger(x)
    x = x(:);
    r = [nanmin(x),nanmax(x)];
end
