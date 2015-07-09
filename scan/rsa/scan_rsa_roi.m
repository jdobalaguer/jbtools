
function scan = scan_rsa_roi(scan)
    %% scan = SCAN_RSA_ROI(scan)
    % RSA region-of interest (ROI)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if scan.job.searchlight, return; end
    
    % estimation
    scan = scan_rsa_roi_estimation(scan);

    % analysis
    scan = scan_rsa_roi_first(scan);
    scan = scan_rsa_roi_second(scan);

    % function
    scan = scan_rsa_roi_function(scan);

    % done
    scan = scan_tool_done(scan);
end
