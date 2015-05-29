
function scan_tool_warning(varargin)
    %% SCAN_TOOL_WARNING(scan,wait,text,val1,val2,..)
    % print a warning, and pause if required
    % scan : [scan] struct
    % wait : are you currently using func_wait() ?
    % text : text to print (see sprintf)
    % val* : values to print (see sprintf)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % default
    scan = varargin{1};
    wait = varargin{2};
    text = sprintf('%s: warning. %s',func_caller(),varargin{3});
    vals = varargin(4:end);
    
    % print warning
    if scan.parameter.analysis.verbose
        cprintf([1,0.5,0],text,vals{:});
        fprintf('\n');
    end
    
    % warning pause
    if scan.parameter.analysis.wpause
        input('Press anything to continue.');
    end
    
    % waitbar marge
    if wait
        fprintf([repmat(' ',1,57),'\n']);
    end
    

end
