
function scan_tool_print(varargin)
    %% SCAN_TOOL_PRINT(scan,progress,text,val1,val2,..)
    % print a message
    % scan      : [scan] struct
    % progress  : are you currently using scan_tool_progress() ?
    % text      : text to print (see sprintf)
    % val*      : values to print (see sprintf)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % default
    scan = varargin{1};
    progress = varargin{2};
    text = varargin{3};
    vals = varargin(4:end);
    print_colour = 'blue';
    
    % print message
    if scan.parameter.analysis.verbose
        cprintf(print_colour,text,vals{:});
        fprintf('\n');
    end
    
    % progress bar marge
    if progress && scan.parameter.analysis.verbose
        fprintf([repmat(' ',1,57),'\n']);
    end
end
