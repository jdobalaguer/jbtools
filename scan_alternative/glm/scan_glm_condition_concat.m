
function scan = scan_glm_condition_concat(scan)
    %% scan = SCAN_GLM_CONDITION_CONCAT(scan)
    % concatenate sessions for the conditions
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % this function assumes similar structure for each session
    % you'll need to re-do this

    %% function
    if ~scan.running.flag.design, return; end
    if ~scan.job.concatSessions,  return; end
    
    % print
    scan_tool_print(scan,false,'\nConatenate session (condition) : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % variables
        u_name = cellfun(@(c){c.name},scan.running.condition{i_subject},'UniformOutput',false);
        u_name = unique([u_name{:}]);
        n_volume = 0;
        
        % condition struct
        condition = struct('name',u_name,'onset',{[]},'subname',{{}},'level',{[]},'duration',{[]});
        for i_session = 1:scan.running.subject.session(i_subject)
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
                name = scan.running.condition{i_subject}{i_session}(i_condition).name;
                condition(strcmp(name,{condition.name})).subname  = scan.running.condition{i_subject}{i_session}(i_condition).subname;
                condition(strcmp(name,{condition.name})).duration = scan.running.condition{i_subject}{i_session}(i_condition).duration;
            end
        end
        
        % session
        for i_session = 1:scan.running.subject.session(i_subject)
            
            % condition
            for i_condition = 1:length(u_name)
                ii_condition = strcmp(u_name{i_condition},{scan.running.condition{i_subject}{i_session}.name});
                if ~any(ii_condition), continue; end
                condition(i_condition).onset = [condition(i_condition).onset ; scan.running.condition{i_subject}{i_session}(ii_condition).onset + scan.parameter.scanner.tr * n_volume];
                condition(i_condition).level = [condition(i_condition).level ; scan.running.condition{i_subject}{i_session}(ii_condition).level]; % we don't z-score before concatenation !!
            end
            
            % increase cumulative volumes
            n_volume = n_volume + size(scan.running.regressor{i_subject}{i_session}.regressor,1);
            
            % wait
            scan_tool_progress(scan,[]);
        end
        
        % save condition
        scan.running.condition{i_subject} = {condition};
    end
    scan_tool_progress(scan,0);
end