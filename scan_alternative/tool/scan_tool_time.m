
function scan = scan_tool_time(scan)
    %% scan = SCAN_TOOL_TIME(scan)
    % print elapsed time since start
    
    %% function
    if ~scan.parameter.analysis.verbose, return; end
    if ~scan.parameter.analysis.time, return; end
    
    % print
    scan_tool_print(scan,false,'\nTotal');
    toc(scan.running.time.start);
end
