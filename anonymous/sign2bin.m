% convert signed to binary
function y = sign2bin(x)
    y               = ones(size(x));
    y(x(:)==-1)     = 0;
    y(isnan(x(:)))  = nan;
end
