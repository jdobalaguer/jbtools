
function scan = scan_preprocess_mkdir(scan)
    %% scan = SCAN_PREPROCESS_MKDIR(scan)
    % create new directories before running the preprocessing
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    file_mkdir(scan.running.directory.job);
    
    % warning
    scan_tool_warning(scan,false,'this is not implemented yet.');
    
end
