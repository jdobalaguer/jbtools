
function scan = scan_conversion_flag(scan)
    %% scan = SCAN_CONVERSION_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % switch
    switch scan.job.whatToDo
        case 'all'
            redo = [1,1];
        case 'to expansion'
            redo = [1,1];
        case 'only dicom'
            redo = [1,0];
        case 'to dicom'
            redo = [1,0];
        case 'only expansion'
            redo = [0,1];
        case 'from expansion'
            redo = [0,1];
        otherwise
            scan_tool_error(scan,'[scan.job.whatToDo] "%s" unknown',scan.job.whatToDo);
    end
    
    % build flags
    flag_args = [{'dicom','expansion'};num2cell(redo)];
    scan.running.flag = struct(flag_args{:});
    
end
