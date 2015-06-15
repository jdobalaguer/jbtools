
function y = sign2bin(x)
    %% y = SIGN2BIN(x)
    % convert signed to binary
    
    %% function
    y               = ones(size(x));
    y(x(:)==-1)     = 0;
    y(isnan(x(:)))  = nan;
end
