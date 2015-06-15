
function scan = scan_glm_regressor_zscore(scan)
    %% scan = SCAN_GLM_REGRESSOR_ZSCORE(scan)
    % apply z-score transformation to the regressor
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    
    % print
    scan_tool_print(scan,false,'\nZ-score regressor : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % session
        for i_session = 1:length(scan.running.regressor{i_subject})
            
            % regressor
            for i_regressor = 1:size(scan.running.regressor{i_subject}{i_session}.regressor,2)
                if scan.running.regressor{i_subject}{i_session}.zscore(i_regressor)
                    scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor) = mat_zscore(scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor));
                end
            end
            
            % wait
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
