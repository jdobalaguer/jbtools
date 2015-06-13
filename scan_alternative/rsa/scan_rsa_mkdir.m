
function scan = scan_rsa_mkdir(scan)
    %% scan = SCAN_RSA_MKDIR(scan)
    % create new directories before running the rsa
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    file_mkdir(scan.running.directory.job);
end
