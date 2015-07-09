
function scan = scan_conversion_flag(scan)
    %% scan = SCAN_CONVERSION_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % switch
    switch scan.job.whatToDo
        % all
        case 'all'
            redo = [1,1];
        % to
        case 'to dicom'
            redo = [1,0];
        case 'to expansion'
            redo = [1,1];
        % only
        case 'only dicom'
            redo = [1,0];
        case 'only expansion'
            redo = [0,1];
        % from
        case 'from expansion'
            redo = [0,1];
        % no
        case 'no dicom'
            redo = [0,1];
        case 'no expansion'
            redo = [1,0];
        otherwise
            scan_tool_error(scan,'[scan.job.whatToDo] "%s" unknown',scan.job.whatToDo);
    end
    
    % build flags
    flag_args = [{'dicom','expansion'};num2cell(redo)];
    scan.running.flag = struct(flag_args{:});
    
end
