
function scan = scan_tool_done(scan)
    %% scan = SCAN_TOOL_DONE(scan)
    % set a function as done
    % to list main functions, try
    %   >> help scan;
    
    %% function
    scan.running.done{end+1} = func_caller();
end
