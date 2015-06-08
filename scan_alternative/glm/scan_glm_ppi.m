
function scan = scan_glm_ppi(scan)
    %% scan = SCAN_GLM_PPI(scan)
    % add psycho-physiological interactions
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    if isempty(scan.job.ppi),     return; end
    
    % print
    scan_tool_print(scan,false,'\nAdd PPI : ');
    scan_tool_progress(scan,sum(scan.running.subject.session)*length(scan.job.ppi));
    
    % ppi
    for i_ppi = 1:length(scan.job.ppi)
        % condition (i.e. psychological)
        condition = scan_tool_convolution(scan,scan.job.ppi(i_ppi).order,scan.job.ppi(i_ppi).condition);

        % subject
        for i_subject = 1:scan.running.subject.number

            % session
            for i_session = 1:length(scan.running.regressor{i_subject})
            
                % regressor (i.e. physiological)
                i_regressor = strcmp(scan.job.ppi(i_ppi).regressor,scan.running.regressor{i_subject}{i_session}.name);
                scan_tool_assert(scan,sum(i_regressor)==1,'none or multiple regressors found for subject "%03i" session "%03i" with the same name "%s"',i_subject,i_session,scan.job.ppi(i_ppi).regressor);
                regressor   = scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor);
                
                % add interaction
                interaction = ztransf(condition{i_subject}{i_session} .* regressor);
                scan.running.regressor{i_subject}{i_session}.name{end+1}        = scan.job.ppi(i_ppi).name;
                scan.running.regressor{i_subject}{i_session}.regressor(:,end+1) = interaction;
                scan.running.regressor{i_subject}{i_session}.filter(end+1)      = false;
                scan.running.regressor{i_subject}{i_session}.zscore(end+1)      = true;
                scan.running.regressor{i_subject}{i_session}.covariate(end+1)   = false;
            end
            
            % wait
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
