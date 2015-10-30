

function scan = scan_initialize_tfce(scan)
    %% scan = SCAN_INITIALIZE_TFCE(scan)
    % initialize TFCE-toolbox setthings
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~struct_isfield(scan,'job.tfce'), return; end
    if ~scan.job.tfce, return; end
    
    % install if required
    if ~scan_glm_tfce_installed(), scan = scan_glm_tfce_install(scan); end
    
    % update
    scan = scan_glm_tfce_update(scan);
end

    