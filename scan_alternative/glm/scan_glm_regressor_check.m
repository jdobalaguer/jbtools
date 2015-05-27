
function scan = scan_glm_regressor_check(scan)
    %% SCAN_GLM_REGRESSOR_CHECK()
    % check regressors for GLM, and ensure the marge
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED,*FPARK>
    
    %% FUNCTION
    for sub = scan.subject.u
        dire_nii_epi3 = strtrim(scan.dire.nii.epi3(sub,:));
        fprintf('Checking regressors for: %s\n',dire_nii_epi3);
        dire_nii_runs = dir([strtrim(dire_nii_epi3),'run*']);
        dire_nii_runs = strcat(strvcat(dire_nii_runs.name),'/');
        nb_runs = size(dire_nii_runs, 1);
        u_run   = 1:nb_runs;
        condition   = load(sprintf('%sfinal_condition_sub_%02i.mat',    scan.dire.glm.regressor,sub),'condition');   condition   = condition.condition;
        realignment = load(sprintf('%sfinal_realignment_sub_%02i.mat',  scan.dire.glm.regressor,sub),'realignment'); realignment = realignment.realignment;
        for i_run = u_run
            % check regressors length
            for i_cond = 1:length(condition{i_run})
                nb_scans_R      = size(realignment{i_run},1);
                scans_cond      = (condition{i_run}{i_cond}.onset ./ scan.pars.tr);
                scans_to_remove = (scans_cond + scan.glm.marge - scan.glm.delay > nb_scans_R);
                if any(scans_to_remove)
                    condition{i_run}{i_cond}.onset(scans_to_remove) = [];
                    for i_level = 1:length(condition{i_run}{i_cond}.level)
                        condition{i_run}{i_cond}.level{i_level}(scans_to_remove) = [];
                    end
                    cprintf([1,0.5,0],'scan_glm_regressor_check: warning. subject %02i run %02i cond %s removed %d samples',sub,u_run(i_run),condition{i_run}{i_cond}.name);
                    fprintf('\n');
                end
            end
            % save regressors
            save(sprintf('%scheck_condition_sub_%02i.mat',scan.dire.glm.regressor,sub),'condition');
            save(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,sub),'condition');
        end
    end
end
