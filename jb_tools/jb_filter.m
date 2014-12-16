
function y = jb_filter(x,f)
    % y = JB_FILTER(x,f)
    % filter elements from a vector
    % x : input vector
    % f : filter function (default "~isnan")
    % y : output (smaller) vector
    % 
    % example
    % y = jb_filter(x,@(a) a>0);
    
    if ~exist('f','var'); f = @(a)~isnan(a); end
    y = x(f(x));
end
