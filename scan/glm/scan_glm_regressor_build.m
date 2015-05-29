
function scan = scan_glm_regressor_build(scan)
    %% SCAN_GLM_REGRESSOR_BUILD()
    % build regressors for GLM
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*FPARK,*NASGU>
    
    %% FUNCTION
    file_mkdir(scan.dire.glm.regressor);
    for sub = scan.subject.u
        condition   = {};
        realignment = {};
        
        % directories and files
        dire_nii_epi3 = strtrim(scan.dire.nii.epi3(sub,:));
        fprintf('Building regressors for: %s\n',dire_nii_epi3);
        dire_nii_runs = dir([strtrim(dire_nii_epi3),'run*']);
        dire_nii_runs = strcat(strvcat(dire_nii_runs.name),'/');
        nb_runs     = size(dire_nii_runs, 1);
        u_run       = 1:nb_runs;
        for i_run = u_run

            % condition
            condition{i_run} = {};
            for i_cond = 1:length(scan.glm.regressor)
                regressor = scan.glm.regressor(i_cond);
                ii_sub   = (regressor.subject == sub);
                ii_run   = (regressor.session == u_run(i_run));
                ii_dis   = (regressor.discard);
                if isempty(ii_dis), ii_dis = false(size(ii_sub)); end
                ii_data  = (ii_sub & ii_run & ~ii_dis);
                
                name     = regressor.name;
                onset    = regressor.onset(ii_data) + scan.pars.reft0 - scan.glm.delay;
                subname  = regressor.subname;
                level    = regressor.level;
                duration = regressor.duration;
                for i_level = 1:length(level), level{i_level} = level{i_level}(ii_data); end
                condition{i_run}{end+1} = struct( ...
                    'name'     , name       , ...
                    'onset'    , {onset}    , ...
                    'subname'  , {subname}  , ...
                    'level'    , {level}    , ...
                    'duration' , {duration} );
            end

            % load/save realignment
            dire_nii_run  = strcat(dire_nii_epi3,strtrim(dire_nii_runs(i_run,:)));
            dire_nii_rea  = strcat(dire_nii_run,'realignment',filesep);
            file_nii_rea  = dir([dire_nii_rea,'rp_*image*.txt']);   file_nii_rea = strcat(dire_nii_rea,strvcat(file_nii_rea.name));
            R = load(file_nii_rea);
            realignment{i_run} = R;
        end
        
        % save
        save(sprintf('%splain_realignment_sub_%02i.mat',    scan.dire.glm.regressor,sub), 'realignment');
        save(sprintf('%sfinal_realignment_sub_%02i.mat',    scan.dire.glm.regressor,sub), 'realignment');
        save(sprintf('%splain_condition_sub_%02i.mat',      scan.dire.glm.regressor,sub), 'condition');
        save(sprintf('%sfinal_condition_sub_%02i.mat',      scan.dire.glm.regressor,sub), 'condition');
    end
end
