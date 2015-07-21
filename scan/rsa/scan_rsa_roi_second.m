
function scan = scan_rsa_roi_second(scan)
    %% scan = SCAN_RSA_ROI_SECOND(scan)
    % RSA second-level analysis (roi)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.second, return; end
    
    % print
    scan_tool_print(scan,false,'\nRSA analysis (second level) : ');
    scan = scan_tool_progress(scan,1);
    
    % second-level analysis
    [~,p,~,stats] = ttest(scan.result.first,[],'tail','right');
    scan.result.second.r = nanmean(scan.result.first,1);
    scan.result.second.p = p;
    scan.result.second.t = stats.tstat;
    
    % wait
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
