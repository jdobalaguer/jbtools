
function scan = scan_initialize_spm(scan)
    %% scan = SCAN_INITIALIZE_SPM(scan)
    % initialize SPM & setthings
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % initialize the job manager
    spm('defaults','fmri')
    spm_get_defaults('cmdline',true);
    spm_get_defaults('mask.thresh',0.2);
    spm_get_defaults('stats.maxmem',scan.parameter.analysis.memory);
    spm_get_defaults('smooth.fwhm',[6,6,6]);
    if any(strcmp(scan.job.type,{'preprocess','glm','tbte'}))
        spm_jobman('initcfg');
    end
end
