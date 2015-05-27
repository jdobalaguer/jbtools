
function s = pair2struct(varargin)
    %% s = PAIR2STRUCT(field1,value1,field2,value2,...)
    % create a structure made of pairs
    % s : resulting struct
    
    %% function
    s = struct(varargin{:});
end