
function scan = scan_rsa_flag(scan)
    %% scan = SCAN_RSA_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
   
    % warning
    if ~isempty(file_list(file_nendsep(scan.running.directory.job)))
        scan_tool_warning(scan,false,'folder "%s" already exists',scan.running.directory.job);
    end
    
    % switch
    switch scan.job.whatToDo
        case 'all'
            redo = [1,1,1,1,1,1];
        otherwise
            error('scan_glm_flag: error. [scan.job.whatToDo] "%s" unknown',scan.job.whatToDo);
    end
    
    % build flags
    flag_args = [{'load','model','estimation','first','second','function'};num2cell(redo)];
    scan.running.flag = struct(flag_args{:});
    
    % one-subject
    if scan.running.subject.number == 1, scan.running.flag.second = false; end
end
