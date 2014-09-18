
function scan = scan_glm_regressor_split(scan)
    %% SCAN_GLM_REGRESSOR_SPLIT()
    % split regressors for GLM (one onset per event)
    % this is used to convolve the input before doing an mvpa analysis
    % see also scan_glm_run
    %          scan_mvpa_run

    %%  WARNINGS
    %#ok<*AGROW,*NASGU>
    
    %% FUNCTION
    for sub = scan.subject.u
        dire_niiepi3 = strtrim(scan.dire.nii.epi3(sub,:));
        fprintf('Split regressors for:    %s\n',dire_niiepi3);

        % load merged regressor
        C_joint = load(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,sub));
        C_joint = C_joint.condition;
        C_split = {};
        
        % split conditions
        for i_run = 1:length(C_joint)
            for i_cond = 1:length(C_joint{i_run})
                for i_onset = 1:length(C_joint{i_run}{i_cond}.onset)
                    tmp = struct();
                    tmp.name        = sprintf('%s_%03i',C_joint{i_run}{i_cond}.name,i_onset);
                    tmp.onset       = C_joint{i_cond}{i_run}.onset(i_onset);
                    tmp.subname     = {};
                    tmp.level       = {};
                    tmp.duration    = 0;
                    C_split{end+1} = tmp;
                end
            end
        end
        
        % save
        condition = {C_split};
        save(sprintf('%ssplit_condition_sub_%02i.mat',scan.dire.glm.regressor,sub),'condition');
        save(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,sub),'condition');
    end
end
