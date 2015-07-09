
function scan = scan_rsa_searchlight(scan)
    %% scan = SCAN_RSA_SEARCHLIGHT(scan)
    % RSA searchlight
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if isempty(scan.job.searchlight) || ~scan.job.searchlight, return; end
    
    % estimation
    scan = scan_rsa_searchlight_estimation(scan);

    % analysis
    scan = scan_rsa_searchlight_first(scan);
    scan = scan_rsa_searchlight_second(scan);

    % function
    scan = scan_rsa_searchlight_function(scan);

    % done
    scan = scan_tool_done(scan);
end
