
function scan = scan_glm_regressor_outer(scan)
    %% SCAN_GLM_REGRESSOR_OUTER()
    % add voxel timecourse as a covariate (e.g. outside of the brain)
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~isfieldp(scan,'glm.outside'), return; end
    if isempty(scan.glm.outside),     return; end
    
    % set scan.glm.outside
    if ischar(scan.glm.outside)
        scan.glm.outside = repmat({scan.glm.outside},1,scan.subject.n);
    else
        assert(iscell(scan.glm.outside),'scan_glm_regressor_outside: error. ')
    end
    
    % do stuff
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        dire_niiepi3 = strtrim(scan.dire.nii.epi3(subject,:));
        fprintf('Outer regressors for:    %s\n',dire_niiepi3);
        dire_niiruns = dir([dire_niiepi3,'run*']); dire_niiruns = strcat(strvcat(dire_niiruns.name),filesep);
        nb_runs     = size(dire_niiruns, 1);
        u_run       = 1:nb_runs;
        
        % load mask
        outer_mask = scan_nifti_load(['data/mask/',scan.glm.outside{i_subject}]);

        % realignment
        realignment = load(sprintf('%sfinal_realignment_sub_%02i.mat',  scan.dire.glm.regressor,subject),'realignment');
        realignment = realignment.realignment;
        for i_run = u_run
            run = u_run(i_run);
            % folders
            dire_niirun  = strcat(dire_niiepi3,strtrim(dire_niiruns(i_run,:)));
            dire_niirun  = [dire_niirun,scan.glm.image,filesep()];
            % files
            u_file        = dir([dire_niirun,'*.nii']);
            n_file        = length(u_file);
            ii_discard    = false(size(u_file));
            for i_file = 1:n_file
                if ~isempty(regexp(u_file(i_file).name,'.*mean.*','match')) % remove mean image
                    ii_discard(i_file) = true;
                end
            end
            u_file(ii_discard) = [];
            u_file        = strcat(dire_niirun,strvcat(u_file.name));
            n_file        = size(u_file,1);
            % load outside timecourse
            outer_vols = nan(n_file,1);
            jb_parallel_progress(n_file);
            for i_file = 1:n_file
                outer_vols(i_file) = nanmean(scan_nifti_load(u_file(i_file,:),outer_mask));
                jb_parallel_progress();
            end
            jb_parallel_progress(0);
            % concatenate
            realignment{i_run}(:,end+1) = outer_vols;
        end
        save(sprintf('%souter_realignment_sub_%02i.mat',  scan.dire.glm.regressor,subject),'realignment');
        save(sprintf('%sfinal_realignment_sub_%02i.mat',  scan.dire.glm.regressor,subject),'realignment');
    end
end