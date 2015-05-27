
function scan = scan_glm_mkdir(scan)
    %% scan = SCAN_GLM_MKDIR(scan)
    % create new directories before running the glm
    
    %% function
    if scan.running.flag.regressor, file_mkdir(scan.running.directory.original.regressor); end
    if scan.running.flag.design,    file_mkdir(scan.running.directory.original.first);     end
    if scan.running.flag.second,    file_mkdir(scan.running.directory.original.second);    end
    
end
