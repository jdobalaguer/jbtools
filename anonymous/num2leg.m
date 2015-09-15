
function leg = num2leg(num,str)
    %% leg = NUM2LEG(num[,str])
    % numbers to legend (cell of string)
    
    %% function
    leg = cell(size(num));
    if ~exist('str','var')
        for i = 1:numel(num), leg{i} = num2str(num(i)); end
    else
        for i = 1:numel(num), leg{i} = sprintf(str,num(i)); end
    end
end
