
function scan = scan_ppi_glm_init(scan)
    %% scan = SCAN_PPI_GLM_INIT(scan)
    % initialise the GLM for a PPI analysis
    % see also scan_initialize
    %          scan_ppi_run

    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % flags
    redo = true(1,5);
    if isfield(scan.glm,'redo'), redo(1:scan.glm.redo-1) = false; end
    do_regressor   = redo(1) || ~exist(scan.dire.glm.regressor ,'dir');
    do_regression  = redo(2) || ~exist(scan.dire.glm.firstlevel,'dir');
    do_firstlevel  = redo(3) || ~exist(scan.dire.glm.firstlevel,'dir');
    do_secondlevel = redo(4) || ~exist(scan.dire.glm.secondlevel,'dir');
    if length(scan.subject.u)<2, do_secondlevel = false; end
    
    % delete
    if do_regressor   && exist(scan.dire.glm.regressor,  'dir'); rmdir(scan.dire.glm.regressor,  's'); end
    if do_regression  && exist(scan.dire.glm.firstlevel, 'dir'); rmdir(scan.dire.glm.firstlevel, 's'); end
    if do_regression  && exist(scan.dire.glm.beta1,      'dir'); rmdir(scan.dire.glm.beta1,      's'); end
    if do_firstlevel  && exist(scan.dire.glm.contrast1,  'dir'); rmdir(scan.dire.glm.contrast1,  's'); end
    if do_firstlevel  && exist(scan.dire.glm.statistic1, 'dir'); rmdir(scan.dire.glm.statistic1, 's'); end
    if do_secondlevel && exist(scan.dire.glm.secondlevel,'dir'); rmdir(scan.dire.glm.secondlevel,'s'); end
    if do_secondlevel && exist(scan.dire.glm.beta2,      'dir'); rmdir(scan.dire.glm.beta2,      's'); end
    if do_secondlevel && exist(scan.dire.glm.contrast2,  'dir'); rmdir(scan.dire.glm.contrast2,  's'); end
    if do_secondlevel && exist(scan.dire.glm.statistic2, 'dir'); rmdir(scan.dire.glm.statistic2, 's'); end
    
    % save it
    scan.ppi.do.regressor   = do_regressor;
    scan.ppi.do.regression  = do_regression;
    scan.ppi.do.firstlevel  = do_firstlevel;
    scan.ppi.do.secondlevel = do_secondlevel;
end
