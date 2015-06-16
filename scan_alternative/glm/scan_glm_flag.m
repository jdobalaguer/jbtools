
function scan = scan_glm_flag(scan)
    %% scan = SCAN_GLM_FLAG(scan)
    % set flags
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % warning
    if ~isempty(file_list(file_nendsep(scan.running.directory.job)))
        scan_tool_warning(scan,false,'folder "%s" already exists. Files in "%s" wont be deleted',scan.running.directory.job,scan.running.directory.copy.root);
    end
    
    % switch
    switch scan.job.whatToDo
        % all
        case 'all'
            redo = [1,1,1,1,1];
        % from
        case 'from design'
            redo = [1,1,1,1,1];
        % no
        case 'no function'
            redo = [1,1,1,1,0];
        % to
        case 'to second'
            redo = [1,1,1,1,0];
        case 'to first'
            redo = [1,1,1,0,0];
        case 'to estimation'
            redo = [1,1,0,0,0];
        case 'to design'
            redo = [1,0,0,0,0];
        % only
        case 'only design'
            redo = [1,0,0,0,0];
        % to-and-function
        case 'taf second'
            redo = [1,1,1,1,1];
        case 'taf first'
            redo = [1,1,1,0,1];
        case 'taf estimation'
            redo = [1,1,0,0,1];
        case 'taf design'
            redo = [1,0,0,0,1];
        otherwise
            scan_tool_error(scan,'[scan.job.whatToDo] "%s" unknown',scan.job.whatToDo);
    end
    
    % build flags
    flag_args = [{'design','estimation','first','second','function'};num2cell(redo)];
    scan.running.flag = struct(flag_args{:});
    
end
