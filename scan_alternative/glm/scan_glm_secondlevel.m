
function scan = scan_glm_secondlevel(scan)
    %% scan = SCAN_GLM_SECONDLEVEL(scan)
    % second level contrast and statistics
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.second, return; end
    
    % build folder
    scan_tool_print(scan,false,'\nBuild folder : ');
    scan_tool_progress(scan,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        for i_contrast = 1:length(scan.running.contrast{i_subject})
            file_first_img  = fullfile(scan.running.directory.original.first{i_subject},sprintf('%s_%04i.img',scan.job.secondLevel,i_contrast));
            file_first_hdr  = fullfile(scan.running.directory.original.first{i_subject},sprintf('%s_%04i.hdr',scan.job.secondLevel,i_contrast));
            file_second_img = fullfile(scan.running.directory.original.second,scan.running.contrast{i_subject}(i_contrast).name,sprintf('%s_subject_%03i.img',scan.job.secondLevel,i_subject));
            file_second_hdr = fullfile(scan.running.directory.original.second,scan.running.contrast{i_subject}(i_contrast).name,sprintf('%s_subject_%03i.hdr',scan.job.secondLevel,i_subject));
            file_mkdir(fileparts(file_second_img));
            copyfile(file_first_img,file_second_img);
            copyfile(file_first_hdr,file_second_hdr);
        end
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
    % second level analyses
    scan_tool_print(scan,false,'\nSPM analysis (second level) : ');
    scan_tool_progress(scan,length(scan.running.contrast{1}));
    j_job = 0;
    for i_contrast = 1:length(scan.running.contrast{1})
        directory_second = fullfile(scan.running.directory.original.second,scan.running.contrast{i_subject}(i_contrast).name);
        % design
        j_job = j_job + 1;
        spm{j_job}.spm.stats.factorial_design.dir                      = {directory_second}; %#ok<*AGROW>
        spm{j_job}.spm.stats.factorial_design.des.t1.scans             = file_list(fullfile(directory_second,'*.img'),'absolute');
        spm{j_job}.spm.stats.factorial_design.cov                      = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        spm{j_job}.spm.stats.factorial_design.masking.tm.tm_none       = 1;    % threshold masking
        spm{j_job}.spm.stats.factorial_design.masking.im               = 1;    % implicit mask
        spm{j_job}.spm.stats.factorial_design.masking.em               = {''}; % explicit mask
        spm{j_job}.spm.stats.factorial_design.globalc.g_omit           = 1;    % dont know what it is
        spm{j_job}.spm.stats.factorial_design.globalm.gmsca.gmsca_no   = 1;    % grand mean scaling
        spm{j_job}.spm.stats.factorial_design.globalm.glonorm          = 1;    % global normalization
        % estimate
        j_job = j_job + 1;
        spm{j_job}.spm.stats.fmri_est.spmmat           = {fullfile(directory_second,'SPM.mat')};
        spm{j_job}.spm.stats.fmri_est.method.Classical = 1;
        % contrast
        j_job = j_job + 1;
        spm{j_job}.spm.stats.con.spmmat                    = {fullfile(directory_second,'SPM.mat')};
        spm{j_job}.spm.stats.con.consess{1}.tcon.name      = scan.running.contrast{1}(i_contrast).name;
        spm{j_job}.spm.stats.con.consess{1}.tcon.convec    = 1; % contrast vector, here just 1, (simple T)
        spm{j_job}.spm.stats.con.consess{1}.tcon.sessrep   = 'none';
        spm{j_job}.spm.stats.con.delete = 1;
        % SPM
        spm_jobman('run',spm(j_job-2:j_job));
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
end
