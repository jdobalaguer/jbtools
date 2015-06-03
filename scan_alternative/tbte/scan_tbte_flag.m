
function scan = scan_tbte_flag(scan)
    %% scan = SCAN_GLM_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    scan.running.flag.design     = false;
    scan.running.flag.estimation = false;
    
    switch scan.job.restartFrom
        case 'design'
            redo = [1,1];
            if ~isempty(file_list(file_nendsep(scan.running.directory.job)))
                scan_tool_warning(scan,false,'folder "%s" already exists. files in "%s" wont be deleted',scan.running.directory.job,scan.running.directory.copy.root);
            end
        case 'estimation'
            redo = [0,1];
        otherwise
            error('scan_tbte_flag: error. job.restartFrom "%s" unknown',scan.job.restartFrom);
    end
    
    if redo(1), scan.running.flag.design     = true; end
    if redo(2), scan.running.flag.estimation = true; end
end
