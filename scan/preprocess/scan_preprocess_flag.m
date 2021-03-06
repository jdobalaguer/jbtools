
function scan = scan_preprocess_flag(scan)
    %% scan = SCAN_PREPROCESS_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % switch
    switch scan.job.whatToDo
        % all
        case 'all'
            redo = [1,1,1,1,1,1,1];
        % to
        case 'to realignment'
            redo = [1,0,0,0,0,0,0];
        case 'to slicetime'
            redo = [1,1,0,0,0,0,0];
        case 'to coregistration'
            redo = [1,1,1,0,0,0,0];
        case 'to segmentation'
            redo = [1,1,1,1,0,0,0];
        case 'to estimation'
            redo = [1,1,1,1,1,0,0];
        case 'to normalisation'
            redo = [1,1,1,1,1,1,0];
        case 'to smooth'
            redo = [1,1,1,1,1,1,1];
        % only
        case 'only realignment'
            redo = [1,0,0,0,0,0,0];
        case 'only slicetime'
            redo = [0,1,0,0,0,0,0];
        case 'only coregistration'
            redo = [0,0,1,0,0,0,0];
        case 'only segmentation'
            redo = [0,0,0,1,0,0,0];
        case 'only estimation'
            redo = [0,0,0,0,1,0,0];
        case 'only normalisation'
            redo = [0,0,0,0,0,1,0];
        case 'only smooth'
            redo = [0,0,0,0,0,0,1];
        % from
        case 'from realignment'
            redo = [1,1,1,1,1,1,1];
        case 'from slicetime'
            redo = [0,1,1,1,1,1,1];
        case 'from coregistration'
            redo = [0,0,1,1,1,1,1];
        case 'from segmentation'
            redo = [0,0,0,1,1,1,1];
        case 'from estimation'
            redo = [0,0,0,0,1,1,1];
        case 'from normalisation'
            redo = [0,0,0,0,0,1,1];
        case 'from smooth'
            redo = [0,0,0,0,0,0,1];
        otherwise
            scan_tool_error(scan,'[scan.job.whatToDo] "%s" unknown',scan.job.whatToDo);
    end
    
    % build flags
    flag_args = [{'realignment','slicetime','coregistration','segmentation','estimation','normalisation','smooth'};num2cell(redo)];
    scan.running.flag = struct(flag_args{:});
    
    % slice-time
    if ~scan.parameter.analysis.st, scan.running.flag.slicetime = 0; end    
end
