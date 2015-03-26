
function scan = scan_ppi_glm_design(scan)
    %% scan = SCAN_PPI_GLM_DESIGN(scan)
    % set the original GLM design for a PPI analysis
    % see also scan_initialize
    %          scan_ppi_run

    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    do_regressor  = scan.ppi.do.regressor;
    do_regression = scan.ppi.do.regression;
    
    % 0 = save
    save_scan();
    
    % 1 = regressors
    if do_regressor,    scan = scan_glm_regressor_build(scan);  save_scan(); end    % REGRESSOR:    build
    if do_regressor,    scan = scan_glm_regressor_check(scan);  save_scan(); end    % REGRESSOR:    check
    if do_regressor,    scan = scan_glm_regressor_merge(scan);  save_scan(); end    % REGRESSOR:    merge
    
    % 2 = first level (regression)
    if do_regression,   scan = scan_glm_first_design(scan);     save_scan(); end    % REGRESSION:   design
    
    %% NESTED
    function save_scan(), save([scan.dire.glm.root,'scan.mat'],'scan'); end
end
