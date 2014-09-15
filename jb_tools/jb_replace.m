
function y = jb_replace(x,a,b)
    % y = JB_REPLACE(x,a,b)
    % x = input vector
    % a = element (found) in x
    % b = element (replaced) in y
    % y = output vector
    
    %% warning
    
    %% assert
    assert(iscell(a) && iscell(b));
    assert(length(a)==length(b),'jb_replace: error. a and b have different vectors');
    
    %% function
    y = x;
    for i = 1:length(a)
        ii = (x == a(i));
        if ~any(ii), warning('jb_replace: warning. not any "%s"',num2str(a(i))); end
        y(ii) = b(i);
    end
    
end