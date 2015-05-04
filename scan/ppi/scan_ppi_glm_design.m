
function scan = scan_ppi_glm_design(scan)
    %% scan = SCAN_PPI_GLM_DESIGN(scan)
    % set the original GLM design for a PPI analysis
    % see also scan_initialize
    %          scan_ppi_run

    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    do = scan.ppi.do;
    
    % 1 = regressors
    if do.regressor,    scan = scan_glm_regressor_build(scan);  save_scan(); end    % REGRESSOR:    build
    if do.regressor,    scan = scan_glm_regressor_outer(scan);  save_scan(); end    % REGRESSOR:    outside covariate
    if do.regressor,    scan = scan_glm_regressor_check(scan);  save_scan(); end    % REGRESSOR:    check
    if do.regressor,    scan = scan_glm_regressor_merge(scan);  save_scan(); end    % REGRESSOR:    merge
    if do.regressor,    scan = scan_glm_regressor_outKF(scan);  save_scan(); end    % REGRESSOR:    outside filtering
    
    % 2 = first level (regression)
    if do.regression,   scan = scan_glm_first_design(scan);     save_scan(); end    % REGRESSION:   design
    
    %% NESTED
    function save_scan(), save([scan.dire.glm.root,'scan.mat'],'scan'); end
end
