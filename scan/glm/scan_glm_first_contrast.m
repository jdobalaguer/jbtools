
function scan = scan_glm_first_contrast(scan)
    %% SCAN_GLM_FIRST_CONTRAST()
    % run the contrasts (first level)
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    jobs = {};
    for i_sub = scan.subject.u
        fprintf('glm first level contrasts for: subject %02i\n',i_sub);
        dir_datglm1 = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,i_sub);
        job = struct();
        job.spm.stats.con.spmmat = {[dir_datglm1,'SPM.mat']};
        for i_con = 1:length(scan.glm.contrast)
            job.spm.stats.con.consess{i_con}.tcon.name      = scan.glm.contrast{i_con}.name;
            job.spm.stats.con.consess{i_con}.tcon.convec    = scan.glm.contrast{i_con}.convec;
            job.spm.stats.con.consess{i_con}.tcon.sessrep   = 'replsc';
        end
        job.spm.stats.con.delete = 1;
        jobs{end+1} = job;
    end
    spm_jobman('run',jobs);


end