
function scan = scan_tool_progress(scan,progress)
    %% scan = SCAN_TOOL_PROGRESS(scan,progress)
    % progress bar tool
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.parameter.analysis.verbose, return; end
    
    % progress
    if isempty(progress) || ~progress
        func_wait(progress,scan.running.file.progress);
    else
        scan.running.file.progress = func_wait(progress);
    end
    
    % time
    if scan.parameter.analysis.time
        if  progress, tic(); end
        if ~progress, toc(); end
    end
end
