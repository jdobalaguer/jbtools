
function s = pair2struct(varargin)
    %% s = PAIR2STRUCT(field1,value1,field2,value2,...)
    % create a structure made of pairs
    % s : resulting struct
    
    %% function
    if isscalar(varargin) && iscell(varargin)
        varargin = [varargin{:}];
    end
    s = struct(varargin{:});
end
