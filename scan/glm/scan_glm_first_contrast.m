
function scan = scan_glm_first_contrast(scan)
    %% SCAN_GLM_FIRST_CONTRAST()
    % run the contrasts (first level)
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    jobs = {};
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('glm first level contrasts for: subject %02i\n',subject);
        dir_datglm1 = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,subject);
        job = struct();
        job.spm.stats.con.spmmat = {[dir_datglm1,'SPM.mat']};
        for i_contrast = 1:length(scan.glm.contrast{i_subject})
            job.spm.stats.con.consess{i_contrast}.tcon.name      = scan.glm.contrast{i_subject}{i_contrast}.name;
            job.spm.stats.con.consess{i_contrast}.tcon.convec    = scan.glm.contrast{i_subject}{i_contrast}.convec;
            job.spm.stats.con.consess{i_contrast}.tcon.sessrep   = 'replsc';
        end
        job.spm.stats.con.delete = 1;
        jobs{end+1} = job;
    end
    spm_jobman('run',jobs);


end