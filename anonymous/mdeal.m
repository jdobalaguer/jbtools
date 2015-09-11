
function varargout = mdeal(x)
    %% [x1,x2,..] = MDEAL(x)
    % unpack a vector
    
    %% function
    assertVector(x);
    x = mat2row(x);
    varargout = num2cell(x);
end
