
function y = cell_replace(x,a,b)
    %% y = CELL_REPLACE(x,a,b)
    % x = input cell
    % a = element (found) in x
    % b = element (replaced) in y
    % y = output cell
    
    %% function
    
    % assert
    assertVector(a,b);
    assertCell(a,b);
    assertSize(a,b);
    
    % replace
    y = x;
    for i = 1:length(a)
        ii = cellfun(@(x)isequaln(x,a{i}),x);
        assertWarning(any(ii),'vec_replace: warning. not any "%s"',num2str(a{i}));
        y(ii) = b(i);
    end
end
