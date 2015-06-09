
function b = bytes(v) 
    %% b = BYTES(v)
    % v : variable to analyse
    % b : size of [v] in bytes   
    
    %% warnings
    %#ok<*INUSD>
    
    %% function
    b = whos('v');
    b = b.bytes;
end
