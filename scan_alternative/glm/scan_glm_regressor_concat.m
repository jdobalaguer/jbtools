
function scan = scan_glm_regressor_concat(scan)
    %% scan = SCAN_GLM_REGRESSOR_CONCAT(scan)
    % concatenate sessions for the regressors
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    if ~scan.job.concatSessions,  return; end
    
    % print
    scan_tool_print(scan,false,'\nConcatenate session (regressor) : ');
    scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % variables
        u_name = [scan.running.regressor{i_subject}{:}];
        u_name = [u_name.name];
        [~,s_name] = unique(u_name,'first');
        u_name = u_name(sort(s_name));
%         u_regressor = scan.running.regressor{i_subject}{1};
        u_regressor = struct();
        u_regressor.name      = u_name;
        u_regressor.regressor = [];
        u_regressor.filter    = nan(size(u_name));
        u_regressor.zscore    = nan(size(u_name));
        u_regressor.covariate = nan(size(u_name));
        
        % concatenate regressors
        for i_session = 1:scan.running.subject.session(i_subject)
            t_regressor = zeros(size(scan.running.regressor{i_subject}{i_session}.regressor,1),length(u_name));
            for i_name = 1:length(u_name)
                i_regressor = strcmp(scan.running.regressor{i_subject}{i_session}.name,u_name{i_name});
                t_regressor(:,i_regressor) = scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor);
                u_regressor.filter(i_regressor)    = scan.running.regressor{i_subject}{i_session}.filter(i_regressor);
                u_regressor.zscore(i_regressor)    = scan.running.regressor{i_subject}{i_session}.zscore(i_regressor);
                u_regressor.covariate(i_regressor) = scan.running.regressor{i_subject}{i_session}.covariate(i_regressor);
            end
            u_regressor.regressor = [u_regressor.regressor ; t_regressor];
        end
        
        % constant
        s_volume = length(scan.running.file.nii.epi3.(scan.job.image){i_subject}{1});
        for i_session = 2:scan.running.subject.session(i_subject)
            n_volume = length(scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session});
            u_regressor.name{end+1} = 'constant';
            u_regressor.regressor(s_volume+(1:n_volume),end+1) = 1;
            u_regressor.filter(end+1) = false;
            u_regressor.zscore(end+1) = false;
            u_regressor.covariate(end+1) = true;
            s_volume = s_volume + n_volume;
        end
        
        % save condition
        scan.running.regressor{i_subject} = {u_regressor};
            
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
end
