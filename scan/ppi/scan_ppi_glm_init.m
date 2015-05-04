
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
    do.regressor   = redo(1) || ~exist(scan.dire.glm.regressor ,'dir');
    do.regression  = redo(2) || ~exist(scan.dire.glm.firstlevel,'dir');
    do.seed        = redo(3);
    do.firstlevel  = redo(4) || ~exist(scan.dire.glm.firstlevel,'dir');
    do.secondlevel = redo(5) || ~exist(scan.dire.glm.secondlevel,'dir');
    if length(scan.subject.u)<2, do.secondlevel = false; end
    
    % delete
    if do.regressor   && exist(scan.dire.glm.regressor,  'dir'); rmdir(scan.dire.glm.regressor,  's'); end
    if do.regression  && exist(scan.dire.glm.firstlevel, 'dir'); rmdir(scan.dire.glm.firstlevel, 's'); end
    if do.regression  && exist(scan.dire.glm.beta1,      'dir'); rmdir(scan.dire.glm.beta1,      's'); end
    if do.firstlevel  && exist(scan.dire.glm.contrast1,  'dir'); rmdir(scan.dire.glm.contrast1,  's'); end
    if do.firstlevel  && exist(scan.dire.glm.statistic1, 'dir'); rmdir(scan.dire.glm.statistic1, 's'); end
    if do.secondlevel && exist(scan.dire.glm.secondlevel,'dir'); rmdir(scan.dire.glm.secondlevel,'s'); end
    if do.secondlevel && exist(scan.dire.glm.beta2,      'dir'); rmdir(scan.dire.glm.beta2,      's'); end
    if do.secondlevel && exist(scan.dire.glm.contrast2,  'dir'); rmdir(scan.dire.glm.contrast2,  's'); end
    if do.secondlevel && exist(scan.dire.glm.statistic2, 'dir'); rmdir(scan.dire.glm.statistic2, 's'); end
    
    % save it
    scan.ppi.do = do;
end
