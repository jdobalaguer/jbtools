
function scan = scan_glm_condition_concat(scan)
    %% scan = SCAN_GLM_CONDITION_CONCAT(scan)
    % concatenate sessions for the conditions
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % this function doesn't work with TBTE ("version" is always empty)
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design, return; end
    if ~scan.job.concatSessions,  return; end
    
    % print
    scan_tool_print(scan,false,'\nConcatenate session (condition) : ');
    scan = scan_tool_progress(scan,sum(cellfun(@numel,scan.running.subject.session)));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % variables
        u_name      = {scan.job.condition.name};
        u_subname   = {scan.job.condition.subname};
        u_duration  = {scan.job.condition.duration};
        n_volume = 0;
        
        % condition struct
        condition = struct('main',u_name,'name',u_name,'version',{''},'onset',{[]},'subname',u_subname,'level',{[]},'duration',{[]});
        
        % session
        [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
        for i_session = 1:n_session
            
            % condition
            for i_condition = 1:length(u_name)
                ii_condition = strcmp(u_name{i_condition},{scan.running.condition{i_subject}{i_session}.name});
                if ~any(ii_condition), continue; end
                condition(i_condition).onset    = [condition(i_condition).onset    ; scan.running.condition{i_subject}{i_session}(ii_condition).onset + scan.parameter.scanner.tr * n_volume];
                condition(i_condition).level    = [condition(i_condition).level    ; scan.running.condition{i_subject}{i_session}(ii_condition).level]; % we don't z-score before concatenation !!
                condition(i_condition).duration = [condition(i_condition).duration ; scan.running.condition{i_subject}{i_session}(ii_condition).duration];
            end
            
            % increase cumulative volumes
            n_volume = n_volume + length(scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session});
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
        
        % remove empty conditions
        r_condition = false(size(u_name));
        for i_condition = 1:length(u_name)
            if isempty(condition(i_condition).onset),  r_condition(i_condition) = 1; end
        end
        condition(r_condition) = [];
        
        % save condition
        scan.running.condition{i_subject} = {condition};
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
