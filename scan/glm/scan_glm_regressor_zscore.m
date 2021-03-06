
function scan = scan_glm_regressor_zscore(scan)
    %% scan = SCAN_GLM_REGRESSOR_ZSCORE(scan)
    % apply z-score transformation to the regressor
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design, return; end
    
    % print
    scan_tool_print(scan,false,'\nZ-score regressor : ');
    scan = scan_tool_progress(scan,sum(cellfun(@numel,scan.running.subject.session)));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % session
        [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
        for i_session = 1:n_session
            
            % regressor
            for i_regressor = 1:size(scan.running.regressor{i_subject}{i_session}.regressor,2)
                if scan.running.regressor{i_subject}{i_session}.zscore(i_regressor)
                    scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor) = mat_zscore(scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor));
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
