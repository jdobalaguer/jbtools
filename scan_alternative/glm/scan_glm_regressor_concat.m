
function scan = scan_glm_regressor_concat(scan)
    %% scan = SCAN_GLM_REGRESSOR_CONCAT(scan)
    % concatenate sessions for the regressors
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    if ~scan.job.concatSessions,  return; end
    
    % print
    fprintf('Conatenate sessions (regressor) : \n');
    func_wait(scan.running.subject.number);
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % variables
        u_regressor = scan.running.regressor{i_subject}{1};
        
        % concatenate regressors
        for i_session = 2:scan.running.subject.session(i_subject)
            u_regressor.regressor = [u_regressor.regressor ; scan.running.regressor{i_subject}{i_session}.regressor];
        end
        
        % offset
        s_volume = size(scan.running.regressor{i_subject}{1}.regressor,1);
        for i_session = 2:scan.running.subject.session(i_subject)
            n_volume = size(scan.running.regressor{i_subject}{i_session}.regressor,1);
            u_regressor.name{end+1} = sprintf('offset %03i',i_session);
            u_regressor.regressor(s_volume+(1:n_volume),end+1) = 1;
            s_volume = s_volume + n_volume;
        end
        
        % save condition
        scan.running.regressor{i_subject} = {u_regressor};
            
        % wait
        func_wait();
    end
    func_wait(0);
    
    % save scan
    scan_job_save_scan(scan);
end