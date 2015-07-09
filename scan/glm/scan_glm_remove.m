
function scan = scan_glm_remove(scan)
    %% scan = SCAN_GLM_REMOVE(scan)
    % remove first volumes for each session
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design, return; end
    
    % print
    scan_tool_print(scan,false,'\nRemove volumes : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            % remove files
            scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session}(1:scan.job.removeVolumes) = [];
            
            % decrease onset
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
                scan.running.condition{i_subject}{i_session}(i_condition).onset = scan.running.condition{i_subject}{i_session}(i_condition).onset - scan.parameter.scanner.tr * scan.job.removeVolumes;
            end
            
            % remove regressor values
            scan.running.regressor{i_subject}{i_session}.regressor(1:scan.job.removeVolumes,:) = [];
            
            % wait
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
