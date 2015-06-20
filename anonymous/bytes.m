
function b = bytes(varargin) 
    %% b = BYTES(v1[,v2][,..])
    % v : variables to analyse
    % b : array with size of {v} in bytes
    
    %% warnings
    %#ok<*INUSD>
    
    %% function
    b  = nan(1,nargin);
    for i = 1:nargin
        v = varargin{i};
        w = whos('v');
        b(i) = w.bytes;
    end
end
