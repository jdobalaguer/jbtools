
function scan = scan_tbte_rmdir(scan)
    %% scan = SCAN_TBTE_RMDIR(scan)
    % delete old directories before running the tbte
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % remove directory
    if any(isdir(scan.running.directory.job))
        scan_tool_warning(scan,false,'will delete folder "%s"',scan.running.directory.job);
        file_rmdir(scan.running.directory.job);
    end
end
