
function scan = scan_initialize_spm(scan)
    %% scan = SCAN_INITIALIZE_SPM(scan)
    % initialize SPM & setthings
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % initialize the job manager
    if any(strcmp(scan.job.type,{'glm','tbte'}))
        spm_jobman('initcfg');
    end
    
end
