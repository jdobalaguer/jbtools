
function scan = scan_ppi_glm_estimation(scan)
    %% scan = SCAN_PPI_GLM_ESTIMATION(scan)
    % estimate the betas in the GLM (for a PPI analysis)
    % see also scan_initialize
    %          scan_ppi_run

    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    do_regression = scan.ppi.do.regression;
    
    % 2 = first level (regression)
    if do_regression,   scan = scan_glm_first_estimate(scan);   save_scan(); end    % REGRESSION:   estimate
    
    %% NESTED
    function save_scan(), save([scan.dire.glm.root,'scan.mat'],'scan'); end
end
