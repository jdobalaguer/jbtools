
function scan = scan_glm_condition_concat(scan)
    %% scan = SCAN_GLM_CONDITION_CONCAT(scan)
    % concatenate sessions for the conditions
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    if ~scan.job.concatSessions,  return; end
    
    % print
    scan_tool_print(scan,false,'\nConatenate session (condition) : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % variables
        u_condition = scan.running.condition{i_subject}{1};
        n_volume = size(scan.running.regressor{i_subject}{1}.regressor,1);
        
        % session
        for i_session = 2:scan.running.subject.session(i_subject)
            
            % condition
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
                u_condition(i_condition).onset = [u_condition(i_condition).onset ; scan.running.condition{i_subject}{i_session}(i_condition).onset + scan.parameter.scanner.tr * n_volume];
                u_condition(i_condition).level = [u_condition(i_condition).level ; scan.running.condition{i_subject}{i_session}(i_condition).level]; % we don't z-score before concatenation !!
            end
            
            % increase cumulative volumes
            n_volume = n_volume + size(scan.running.regressor{i_subject}{i_session}.regressor,1);
            
            % wait
            scan_tool_progress(scan,[]);
        end
        
        % save condition
        scan.running.condition{i_subject} = {u_condition};
    end
    scan_tool_progress(scan,0);
end
