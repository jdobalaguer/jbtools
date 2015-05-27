
function scan = scan_glm_regressor_merge(scan)
    %% SCAN_GLM_REGRESSOR_MERGE()
    % merge regressors for GLM
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*AGROW,*NASGU,*FPARK>
    
    %% FUNCTION
    if ~scan.glm.pooling, return; end
    
    for sub = scan.subject.u
        dire_niiepi3 = strtrim(scan.dire.nii.epi3(sub,:));
        fprintf('Merge regressors for:    %s\n',dire_niiepi3);
        dire_niiruns = dir([dire_niiepi3,'run*']); dire_niiruns = strcat(strvcat(dire_niiruns.name),'/');
        nb_runs     = size(dire_niiruns, 1);
        u_run       = 1:nb_runs;

        % realignment
        nb_volumes = nan(size(u_run));
        tmp_cond = load(sprintf('%sfinal_realignment_sub_%02i.mat',  scan.dire.glm.regressor,sub),'realignment');
        tmp_cond = tmp_cond.realignment;
        R_merged   = zeros(0,size(tmp_cond{1},2));
        for i_run = u_run
            run = u_run(i_run);
            % run onset
            R_merged            = [R_merged,zeros(size(R_merged,1),1)];
            tmp_cond{i_run}   = [tmp_cond{i_run}, zeros(size(tmp_cond{i_run},1),i_run-1), ones(size(tmp_cond{i_run},1),1)];
            % concatenate
            R_merged = [R_merged ; tmp_cond{i_run}];
            nb_volumes(i_run) = size(tmp_cond{i_run},1);
        end
        R_merged(:,end) = [];
        realignment     = {R_merged};
        save(sprintf('%smerge_realignment_sub_%02i.mat',  scan.dire.glm.regressor,sub),'realignment');
        save(sprintf('%sfinal_realignment_sub_%02i.mat',  scan.dire.glm.regressor,sub),'realignment');

        % condition
        onset = 0;
        C_unmerged = load(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,sub),'condition');
        C_unmerged = C_unmerged.condition;
        C_merged   = C_unmerged{1};
        for i_run = 1:nb_runs-1
            onset = onset + scan.pars.tr * nb_volumes(i_run);
            for i_cond = 1:length(C_merged)
                C_merged{i_cond}.onset = jb_vectorcat(C_merged{i_cond}.onset, C_unmerged{i_run+1}{i_cond}.onset + onset);
                for i_level = 1:length(C_merged{i_cond}.level)
                    C_merged{i_cond}.level{i_level} = jb_vectorcat(C_merged{i_cond}.level{i_level}, C_unmerged{i_run+1}{i_cond}.level{i_level});
                end
            end

        end
        condition = {C_merged};
        save(sprintf('%smerge_condition_sub_%02i.mat',scan.dire.glm.regressor,sub),'condition');
        save(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,sub),'condition');
    end
end