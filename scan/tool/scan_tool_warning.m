
function scan_tool_warning(varargin)
    %% SCAN_TOOL_WARNING(scan,progress,text,val1,val2,..)
    % print a warning, and pause if required
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
    text = sprintf('%s: warning. %s',func_caller(),varargin{3});
    vals = varargin(4:end);
    
    % print warning
    if scan.parameter.analysis.verbose
        cprintf(scan.parameter.analysis.color.warning,text,vals{:});
        fprintf('\n');
    end
    
    % warning pause
    if scan.parameter.analysis.wpause
        cprintf(scan.parameter.analysis.color.warning,'Press return to continue. ');
        input('');
    end
    
    % progress bar marge
    if progress && scan.parameter.analysis.verbose
        fprintf([repmat(' ',1,57),'\n']);
    end
end
