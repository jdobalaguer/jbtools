
function scan = scan_glm_rmdir(scan)
    %% scan = SCAN_GLM_RMDIR(scan)
    % delete old directories before running the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % first level analyses
    if scan.running.flag.design,
        for i_subject = 1:scan.running.subject.number
            file_rmdir(scan.running.directory.original.first{i_subject});
        end
    end
    
    % second level analyses
    if scan.running.flag.second
        file_rmdir(scan.running.directory.original.second);
    end
    
end
