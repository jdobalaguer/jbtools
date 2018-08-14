
function y = loglinspace(d1,d2,n)
    %% y = LOGLINSPACE(d1,d2,n)
    % like linspace but in logarithmic scale
    
    %% function
    func_default('n',100);
    y = power(10,linspace(log10(d1),log10(d2),n));
end
