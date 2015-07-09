
function b = scan_tool_isdone(scan)
    %% b = SCAN_TOOL_ISDONE(scan)
    % set a function as done
    % to list main functions, try
    %   >> help scan;
    
    %% function
    b = struct_isfield(scan,'running.done') && any(strcmp(scan.running.done,func_caller()));
end
