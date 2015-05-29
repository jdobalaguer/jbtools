
function scan = scan_initialize_spm(scan)
    %% scan = SCAN_INITIALIZE_SPM(scan)
    % initialize SPM & setthings
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % initialize the job manager
    spm_jobman('initcfg');
    
    % enforce default format to NIFTI
    global defaults;
    defaults.images.format = 'nii';
    
end