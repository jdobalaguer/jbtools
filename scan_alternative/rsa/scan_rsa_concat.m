
function scan = scan_rsa_concat(scan)
    %% scan = SCAN_RSA_CONCAT(scan)
    % concatenate sessions
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.job.concatSessions, return; end
    
    % concatenation
    scan.running.subject.session(:) = 1;
    
    % done
    scan = scan_tool_done(scan);
end
