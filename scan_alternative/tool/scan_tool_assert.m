
function scan_tool_assert(varargin)
    %% SCAN_TOOL_ASSERT(scan,condition,text,val1,val2,..)
    % assert condition or print an error
    % scan      : [scan] struct
    % condition : condition to assert
    % text      : text to print (see sprintf)
    % val*      : values to print (see sprintf)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % default
    scan = varargin{1}; %#ok<*NASGU>
    cond = varargin{2};
    text = sprintf('%s: error. %s',func_caller(),varargin{3});
    vals = varargin(4:end);
    
    % throw error
    if ~cond, error(text,vals{:}); end
end
