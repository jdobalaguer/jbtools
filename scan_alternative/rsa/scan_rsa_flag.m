
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
            redo = [1,1,1,1,1,1,1];
%         case 'from concatenation'
%             redo = [0,1,1,1,1,1,1];
%         case 'from searchlight'
%             redo = [0,0,1,1,1,1,1];
%         case 'from rdm'
%             redo = [0,0,0,1,1,1,1];
%         case 'from model'
%             redo = [0,0,0,0,1,1,1];
%         case 'from comparison'
%             redo = [0,0,0,0,0,1,1];
        case 'no function'
            redo = [0,0,0,0,0,0,1];
        case 'to comparison'
            redo = [1,1,1,1,1,1,0];
        case 'to model'
            redo = [1,1,1,1,1,0,0];
        case 'to rdm'
            redo = [1,1,1,1,0,0,0];
        case 'to searchlight'
            redo = [1,1,1,0,0,0,0];
        case 'to concatenation'
            redo = [1,1,0,0,0,0,0];
        case 'only load'
            redo = [1,0,0,0,0,0,0];
        case 'only concatenation'
            redo = [0,1,0,0,0,0,0];
        case 'only searchlight'
            redo = [0,0,1,0,0,0,0];
        case 'only rdm'
            redo = [0,0,0,1,0,0,0];
        case 'only model'
            redo = [0,0,0,0,1,0,0];
        case 'only comparison'
            redo = [0,0,0,0,0,1,0];
        case 'only function'
            redo = [0,0,0,0,0,0,1];
        otherwise
            error('scan_glm_flag: error. [scan.job.whatToDo] "%s" unknown',scan.job.whatToDo);
    end
    
    % build flags
    flag_args = [{'load','concatenation','searchlight','rdm','model','comparison','function'};num2cell(redo)];
    scan.running.flag = struct(flag_args{:});
    
end
