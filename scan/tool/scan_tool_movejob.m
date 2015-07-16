
function scan = scan_tool_movejob(scan)
    %% scan = SCAN_TOOL_MOVEJOB(scan)
    % move an existing job to another folder
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % move directory
    if file_match(scan.running.directory.job)
        d = dir(scan.running.directory.job); d = d.date;
        f = strcat(file_nendsep(scan.running.directory.job),' ',d);
        movefile(scan.running.directory.job,f);
    end
    
end
