
function scan = scan_glm_regressor_filter(scan)
    %% scan = SCAN_GLM_REGRESSOR_FILTER(scan)
    % apply high-pass filter to the regressor (as it's done with the neural signal)
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design, return; end
    
    % SPM
    hpf = spm_get_defaults('stats.fmri.hpf');
    
    % print
    scan_tool_print(scan,false,'\nFilter regressor : ');
    scan = scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % session
        for i_session = 1:length(scan.running.regressor{i_subject})
            
            % regressor
            for i_regressor = 1:size(scan.running.regressor{i_subject}{i_session}.regressor,2)
                if scan.running.regressor{i_subject}{i_session}.filter,
                    r = scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor);
                    K = struct('HParam',hpf,'row',1:size(r,1),'RT',scan.parameter.scanner.tr);
                    K = spm_filter(K);
                    r = spm_filter(K,r);
                    scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor) = r;
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
