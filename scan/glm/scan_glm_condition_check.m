
function scan = scan_glm_condition_check(scan)
    %% scan = SCAN_GLM_condition_CHECK(scan)
    % check conditions for GLM, and ensure the marge
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design, return; end
    
    % print
    scan_tool_print(scan,false,'\nCheck condition : ');
    scan = scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % session
        for i_session = 1:scan.running.subject.session(i_subject)
            
            % number of volumes (the from covariate)
            n_volume = length(scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session});
            
            % check condition length
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
                scans_to_remove = (scan.running.condition{i_subject}{i_session}(i_condition).onset - scan.job.delayOnset > n_volume .* scan.parameter.scanner.tr - scan.job.margeFromEnd);
                
                % remove trials
                if any(scans_to_remove)
                    scan.running.condition{i_subject}{i_session}(i_condition).onset(scans_to_remove) = [];
                    if ~isempty(scan.running.condition{i_subject}{i_session}(i_condition).level),
                        scan.running.condition{i_subject}{i_session}(i_condition).level(scans_to_remove,:) = [];
                    end
                    scan_tool_warning(scan,true,'subject "%03i" session "%03i" condition "%s" removed %d samples',scan.running.subject.unique(i_subject),i_session,scan.running.condition{i_subject}{i_session}(i_condition).name,sum(scans_to_remove));
                end
                
            end
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
