
function y = jb_replace(x,a,b)
    % y = JB_REPLACE(x,a,b)
    % x = input vector
    % a = element (found) in x
    % b = element (replaced) in y
    % y = output vector
    
    %% warning
    
    %% assert
    assert(iscell(a) && iscell(b),'jb_replace: error. a and b must be cells');
    assert(length(a)==length(b),'jb_replace: error. a and b have different vectors');
    
    %% function
    y = x;
    for i = 1:length(a)
        if isnan(a{i}), ii = isnan(x);
        else            ii = (x == a{i});
        end
        assertWarning(any(ii),'jb_replace: warning. not any "%s"',num2str(a{i}));
        y(ii) = b{i};
    end
    
end