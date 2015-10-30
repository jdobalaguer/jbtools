
function scan = scan_glm_tfce(scan)
    %% scan = SCAN_GLM_TFCE(scan)
    % threshold-free cluster enhancement (for multiple comparisons correction)
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.second, return; end
    if ~scan.job.tfce, return; end
    
    % second level analyses
    scan_tool_print(scan,false,'\nSPM analysis (TFCE) : ');
    scan = scan_tool_progress(scan,length(scan.running.contrast{1}));
    j_job = 0;
    
    for i_contrast = 1:length(scan.running.contrast{1})
        directory_second = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
        % TFCE
        j_job = j_job + 1;
        spm{j_job}.spm.tools.tfce_estimate.spmmat = {fullfile(directory_second,'SPM.mat')}; %#ok<*AGROW>
        spm{j_job}.spm.tools.tfce_estimate.mask = '';
        spm{j_job}.spm.tools.tfce_estimate.conspec.titlestr = sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order);
        spm{j_job}.spm.tools.tfce_estimate.conspec.contrasts = 1;
        spm{j_job}.spm.tools.tfce_estimate.conspec.n_perm = max(scan.job.tfce,1000);
        spm{j_job}.spm.tools.tfce_estimate.conspec.vFWHM = 0;
        spm{j_job}.spm.tools.tfce_estimate.tbss = 0;
        spm{j_job}.spm.tools.tfce_estimate.openmp = 1;
        % SPM
        evalc('spm_jobman(''run'',spm(j_job))');
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.tfce = spm;
    
    % done
    scan = scan_tool_done(scan);
end
