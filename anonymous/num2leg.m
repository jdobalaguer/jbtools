
function leg = num2leg(num)
    % numbers to legend (cell of string)
    
    assert(isvector(num),'num2leg: error. not a vector');
    leg = cell(length(num));
    for i = 1:length(num)
        leg{i} = num2str(num(i));
    end
    
end
    