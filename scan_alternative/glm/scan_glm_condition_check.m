
function scan = scan_glm_condition_check(scan)
    %% scan = SCAN_GLM_condition_CHECK(scan)
    % check conditions for GLM, and ensure the marge
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    
    % print
    fprintf('Checking conditions : \n');
    func_wait(sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % session
        for i_session = 1:scan.running.subject.session(i_subject)
            
            % number of volumes (the from covariate)
            n_volume = size(scan.running.regressor{i_subject}{i_session}.regressor,1);
            
            % check condition length
            for i_condition = 1:length(length(scan.running.condition{i_subject}{i_session}))
                scans_condition = (scan.running.condition{i_subject}{i_session}{i_condition}.onset ./ scan.parameter.scanner.tr);
                scans_to_remove = (scans_condition + scan.job.margeFromEnd - scan.job.delayOnset > n_volume);
                
                % remove trials
                if any(scans_to_remove)
                    scan.running.condition{i_subject}{i_session}{i_condition}.onset(scans_to_remove) = [];
                    for i_level = 1:length(scan.running.condition{i_subject}{i_session}{i_condition}.level)
                        scan.running.condition{i_subject}{i_session}{i_condition}.level(scans_to_remove,:) = [];
                    end
                    scan_tool_warning(scan,true,'subject "%03i" session "%03i" condition "%s" removed %d samples',scan.running.subject.unique(i_subject),i_session,scan.running.condition{i_subject}{i_session}{i_condition}.name,sum(scans_to_remove));
                end
                
                % wait
                func_wait();
            end
        end
    end
    func_wait(0);
    
    % save scan
    scan_job_save_scan(scan);
end
