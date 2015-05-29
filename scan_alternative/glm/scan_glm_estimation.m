
function scan = scan_glm_estimation(scan)
    %% scan = SCAN_GLM_ESTIMATION(scan)
    % estimate beta values
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.estimation, return; end
    
    % print
    fprintf('SPM Estimation : \n');
    func_wait(scan.running.subject.number);
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        %job
        spm{i_subject}.spm.stats.fmri_est.spmmat = {fullfile(scan.running.directory.original.first{i_subject},'SPM.mat')}; %#ok<*AGROW>
        spm{i_subject}.spm.stats.fmri_est.method.Classical = 1;
        
       % wait
        func_wait();
    end
    func_wait(0);
    
    % SPM
    spm_jobman('run',spm);
end
