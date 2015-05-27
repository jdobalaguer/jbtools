
function scan = scan_glm_flag(scan)
    %% scan = SCAN_GLM_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> scan;
    
    %% function
    
    scan.running.flag.regressor  = true;
    scan.running.flag.design     = true;
    scan.running.flag.estimation = true;
    scan.running.flag.contrast   = true;
    scan.running.flag.first      = true;
    scan.running.flag.second     = true;
    
    switch scan.job.redo
        case 'all'
            redo = [1,1,1,1,1,1];
        case 'design'
            redo = [0,1,1,1,1,1];
        case 'estimation'
            redo = [0,0,1,1,1,1];
        case 'contrast'
            redo = [0,0,0,1,1,1];
        case 'first'
            redo = [0,0,0,0,1,1];
        case 'second'
            redo = [0,0,0,0,0,1];
        otherwise
            error('scan_glm_flag: error. redo "%s" unknown',scan.job.redo);
    end
    
    if redo(1), scan.running.flag.regressor  = false; end
    if redo(2), scan.running.flag.design     = false; end
    if redo(3), scan.running.flag.estimation = false; end
    if redo(4), scan.running.flag.contrast   = false; end
    if redo(5), scan.running.flag.first      = false; end
    if redo(6), scan.running.flag.second     = false; end
end
