
function scan = scan_glm_rmdir(scan)
    %% scan = SCAN_GLM_RMDIR(scan)
    % delete old directories before running the glm
    
    %% function
    if scan.running.flag.regressor, file_rmdir(scan.running.directory.original.regressor); end
    if scan.running.flag.design,    file_rmdir(scan.running.directory.original.first);     end
    if scan.running.flag.second,    file_rmdir(scan.running.directory.original.second);    end
    
end
