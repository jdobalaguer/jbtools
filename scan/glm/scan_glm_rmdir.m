
function scan = scan_glm_rmdir(scan)
    %% scan = SCAN_GLM_RMDIR(scan)
    % delete old directories before running the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % remove directory
    if any(isdir(scan.running.directory.job))
        scan_tool_warning(scan,true,'will delete folder "%s"',scan.running.directory.job);
        file_rmdir(scan.running.directory.job);
    end
    
end
