
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
        % all
        case 'all'
            redo = [1,1,1,1,1,1];
        % from
        case 'from load'
            redo = [1,1,1,1,1,1];
        % no
        case 'no function'
            redo = [1,1,1,1,1,0];
        % to
        case 'to load'
            redo = [1,0,0,0,0,0];
        case 'to model'
            redo = [1,1,0,0,0,0];
        case 'to estimation'
            redo = [1,1,1,0,0,0];
        case 'to first'
            redo = [1,1,1,1,0,0];
        case 'to second'
            redo = [1,1,1,1,1,0];
        case 'to function'
            redo = [1,1,1,1,1,1];
        % only
        case 'only load'
            redo = [1,0,0,0,0,0];
        % to-and-function
        case 'taf load'
            redo = [1,0,0,0,0,1];
        case 'taf model'
            redo = [1,1,0,0,0,1];
        case 'taf estimation'
            redo = [1,1,1,0,0,1];
        case 'taf first'
            redo = [1,1,1,1,0,1];
        case 'taf second'
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
