
function scan = scan_glm_flag(scan)
    %% scan = SCAN_GLM_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    scan.running.flag.design     = false;
    scan.running.flag.estimation = false;
    scan.running.flag.contrast   = false;
    scan.running.flag.first      = false;
    scan.running.flag.second     = false;
    
    switch scan.job.restartFrom
        case 'all'
            redo = [1,1,1,1,1];
            if ~isempty(file_list(file_nendsep(scan.running.directory.job)))
                scan_tool_warning(scan,false,'folder "%s" already exists.\nFiles in "%s" wont be deleted',scan.running.directory.job,scan.running.directory.copy.root);
            end
        case 'from_estimation'
            redo = [0,1,1,1,1];
        case 'from_contrast'
            redo = [0,0,1,1,1];
        case 'from_first'
            redo = [0,0,0,1,1];
        case 'from_second'
            redo = [0,0,0,0,1];
        otherwise
            error('scan_glm_flag: error. job.restartFrom "%s" unknown',scan.job.restartFrom);
    end
    
    if redo(1), scan.running.flag.design     = true; end
    if redo(2), scan.running.flag.estimation = true; end
    if redo(3), scan.running.flag.contrast   = true; end
    if redo(4), scan.running.flag.first      = true; end
    if redo(5), scan.running.flag.second     = true; end
end
