
function scan = scan_tbte_flag(scan)
    %% scan = SCAN_TBTE_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % warning
    if ~isempty(file_list(file_nendsep(scan.running.directory.job)))
        scan_tool_warning(scan,false,'folder "%s" already exists.\nFiles in "%s" wont be deleted',scan.running.directory.job,scan.running.directory.copy.root);
    end
    
    % switch
    switch scan.job.whatToDo
        case 'all'
            redo = [1,1,1];
        case 'from estimation'
            redo = [0,1,1];
        case 'no function'
            redo = [1,1,0];
        case 'to estimation'
            redo = [1,1,0];
        case 'only design'
            redo = [1,0,0];
        case 'only estimation'
            redo = [0,1,0];
        case 'only function'
            redo = [0,0,1];
        otherwise
            error('scan_tbte_flag: error. [scan.job.whatToDo] "%s" unknown',scan.job.whatToDo);
    end
    
    % build flags
    flag_args = [{'design','estimation','function'};num2cell(redo)];
    scan.running.flag = struct(flag_args{:});
    
end
