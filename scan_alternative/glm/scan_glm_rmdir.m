
function scan = scan_glm_rmdir(scan)
    %% scan = SCAN_GLM_RMDIR(scan)
    % delete old directories before running the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % first level analyses
    if scan.running.flag.design,
        scan_tool_warning(scan,false,'will delete "original:first" folders');
        for i_subject = 1:scan.running.subject.number
            file_rmdir(scan.running.directory.original.first{i_subject});
        end
    end
    
    % second level analyses
    if scan.running.flag.second
        scan_tool_warning(scan,false,'will delete "original:second" folders');
        file_rmdir(scan.running.directory.original.second);
    end
    
end
