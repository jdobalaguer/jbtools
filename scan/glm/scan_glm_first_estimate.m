
function scan = scan_glm_first_estimate(scan)
    %% SCAN_GLM_FIRST_ESTIMATE()
    % estimate the beta values (first level)
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW>
    
    %% FUNCTION
    jobs = {};
    for i_sub = scan.subject.u
        dire_datglm1 = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,i_sub);
        fprintf('GLM betas estimate for:  %s\n',dire_datglm1);
        job = struct();
        job.spm.stats.fmri_est.spmmat = {[dire_datglm1,'SPM.mat']};
        job.spm.stats.fmri_est.method.Classical = 1;
        jobs{end+1} = job;
    end
    spm_jobman('run',jobs);

end