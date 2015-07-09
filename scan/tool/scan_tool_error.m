
function scan_tool_error(varargin)
    %% SCAN_TOOL_ERROR(scan,text,val1,val2,..)
    % print an error
    % scan      : [scan] struct
    % text      : text to print (see sprintf)
    % val*      : values to print (see sprintf)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % default
    scan = varargin{1};
    text = sprintf('%s: error. %s',func_caller(),varargin{2});
    vals = varargin(3:end);
    
    % throw error
    error(text,vals{:});
end
