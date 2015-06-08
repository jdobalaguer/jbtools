
function scan = scan_preprocess_flag(scan)
    %% scan = SCAN_PREPROCESS_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % switch
    switch scan.job.whatToDo
        case 'all'
            redo = [1,1,1,1,1,1,1];
        case 'to slicetime'
            redo = [1,0,0,0,0,0,0];
        case 'to realignment'
            redo = [1,1,0,0,0,0,0];
        case 'to coregistration'
            redo = [1,1,1,0,0,0,0];
        case 'to estimation'
            redo = [1,1,1,1,0,0,0];
        case 'to normalisation'
            redo = [1,1,1,1,1,0,0];
        case 'to smooth'
            redo = [1,1,1,1,1,1,0];
        case 'to function'
            redo = [1,1,1,1,1,1,1];
        case 'no function'
            redo = [1,1,1,1,1,1,0];
        case 'only slicetime'
            redo = [1,0,0,0,0,0,0];
        case 'only realignment'
            redo = [0,1,0,0,0,0,0];
        case 'only coregistration'
            redo = [0,0,1,0,0,0,0];
        case 'only estimation'
            redo = [0,0,0,1,0,0,0];
        case 'only normalisation'
            redo = [0,0,0,0,1,0,0];
        case 'only smooth'
            redo = [0,0,0,0,0,1,0];
        case 'only function'
            redo = [0,0,0,0,0,0,1];
        case 'from slicetime'
            redo = [1,0,0,0,0,0,0];
        case 'from realignment'
            redo = [0,1,0,0,0,0,0];
        case 'from coregistration'
            redo = [0,0,1,0,0,0,0];
        case 'from estimation'
            redo = [0,0,0,1,0,0,0];
        case 'from normalisation'
            redo = [0,0,0,0,1,0,0];
        case 'from smooth'
            redo = [0,0,0,0,0,1,0];
        case 'from function'
            redo = [0,0,0,0,0,0,1];
        otherwise
            scan_tool_error(scan,'[scan.job.whatToDo] "%s" unknown',scan.job.whatToDo);
    end
    
    % build flags
    flag_args = [{'slicetime','realignment','coregistration','estimation','normalisation','smooth','function'};num2cell(redo)];
    scan.running.flag = struct(flag_args{:});
    
end
