
function scan = scan_glm_estimation(scan)
    %% scan = SCAN_GLM_ESTIMATION(scan)
    % estimate beta values
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.estimation, return; end
    
    % print
    scan_tool_print(scan,false,'\nSPM Estimation : ');
    scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        %job
        spm{i_subject}.spm.stats.fmri_est.spmmat = {fullfile(scan.running.directory.original.first{i_subject},'SPM.mat')}; %#ok<*AGROW>
        spm{i_subject}.spm.stats.fmri_est.method.Classical = 1;
        
        % SPM
        spm_jobman('run',spm(i_subject));

       % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
end
