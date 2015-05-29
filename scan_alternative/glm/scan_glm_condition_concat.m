
function scan = scan_glm_condition_concat(scan)
    %% scan = SCAN_GLM_CONDITION_CONCAT(scan)
    % concatenate sessions for the conditions
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    if ~scan.job.concatSessions,  return; end
    
    % print
    fprintf('Conatenate sessions (condition) : \n');
    func_wait(sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % variables
        u_condition = scan.running.condition{i_subject}{1};
        n_volume = size(scan.running.regressor{i_subject}{1}.regressor,1) + 1;
        
        % session
        for i_session = 2:scan.running.subject.session(i_subject)
            
            % condition
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
                u_condition{i_condition}.onset = [u_condition{i_condition}.onset ; scan.running.condition{i_subject}{i_session}{i_condition}.onset + scan.parameter.scanner.tr * n_volume];
                u_condition{i_condition}.level = [u_condition{i_condition}.level ; scan.running.condition{i_subject}{i_session}{i_condition}.level]; % we don't z-score before concatenation !!
            end
            
            % increase cumulative volumes
            n_volume = n_volume + size(scan.running.regressor{i_subject}{i_session}.regressor,1);
            
            % wait
            func_wait();
        end
        
        % save condition
        scan.running.condition{i_subject} = {u_condition};
    end
    func_wait(0);
    
    % save scan
    scan_job_save_scan(scan);
end