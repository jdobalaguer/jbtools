
function scan_tool_progress(scan,progress)
    %% SCAN_TOOL_PROGRESS(scan,progress)
    % progress bar tool
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.parameter.analysis.verbose, return; end
    
    % progress
    func_wait(progress);
    
    % time
    if scan.parameter.analysis.time
        if  progress, tic(); end
        if ~progress, toc(); end
    end
    
end
