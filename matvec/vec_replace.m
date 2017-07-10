
function y = vec_replace(x,a,b)
    %% y = VEC_REPLACE(x,a,b)
    % x = input vector
    % a = cell with elements (found) in x
    % b = cell with elements (replaced) in y
    % y = output vector
    
    %% function
    
    % assert
    assertVector(a,b);
    assertCell(a,b);
    assertSize(a,b);
    
    % replace
    y = double(x);
    for i = 1:length(a)
        if isnan(a{i}), ii = isnan(x);
        else            ii = (x == a{i});
        end
        assertWarning(any(ii(:)),'vec_replace: warning. not any "%s"',num2str(a{i}));
        y(ii) = b{i};
    end
end
