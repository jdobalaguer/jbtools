
function scan = scan_glm_run(scan)
    %% scan = SCAN_GLM_RUN(scan)
    % runs a General Linear Model (GLM)
    % see also scan_initialize
    %          scan_preprocess_run
    %          scan_mvpa_run

    %% WARNINGS
    %#ok<*NASGU>
    
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
    
    % SPM
    if ~exist('spm.m','file'), spm8_add_paths(); end
    spm_jobman('initcfg');
    
    % create folder
    mkdirp(scan.dire.glm.root);
    save_scan();
    
    % 1 = regressors
    if do_regressor,    scan = scan_glm_regressor_build(scan);  save_scan(); end    % REGRESSOR:    build
    if do_regressor,    scan = scan_glm_regressor_check(scan);  save_scan(); end    % REGRESSOR:    check
    if do_regressor,    scan = scan_glm_regressor_merge(scan);  save_scan(); end    % REGRESSOR:    merge
    
    % 2 = first level (regression)
    if do_regression,   scan = scan_glm_first_design(scan);     save_scan(); end    % REGRESSION:   design
    if do_regression,   scan = scan_glm_first_estimate(scan);   save_scan(); end    % REGRESSION:   estimate
    
    % 3 = first level (contrast and statistics)
                        scan = scan_glm_setcontrasts(scan);     save_scan();        % FIRST LEVEL:  set contrasts
    if do_firstlevel,   scan = scan_glm_first_contrast(scan);   save_scan(); end    % FIRST LEVEL:  run contrasts and statistics
    
    % 4 = second level
    if do_secondlevel,  scan = scan_glm_second_copy(scan);      save_scan(); end    % SECOND LEVEL: copy files from first level
    if do_secondlevel,  scan = scan_glm_second_contrast(scan);  save_scan(); end    % SECOND LEVEL: run contrasts and statistics
   
    % copy
    glm_copy = false(5); if isfield(scan.glm,'copy'), glm_copy = scan.glm.copy; end
    if glm_copy(1),     scan = scan_glm_copy_beta1(scan);       save_scan(); end    % COPY:         beta      (first level)
    if glm_copy(2),     scan = scan_glm_copy_contrast1(scan);   save_scan(); end    % COPY:         contrast  (first level)
    if glm_copy(3),     scan = scan_glm_copy_statistic1(scan);  save_scan(); end    % COPY:         statistic (first level)
    if glm_copy(4),     scan = scan_glm_copy_beta2(scan);       save_scan(); end    % COPY:         beta      (second level)
    if glm_copy(5),     scan = scan_glm_copy_contrast2(scan);   save_scan(); end    % COPY:         contrast  (second level)
    if glm_copy(6),     scan = scan_glm_copy_statistic2(scan);  save_scan(); end    % COPY:         statistic (second level)

    %% AUXILIAR
    function save_scan(), save([scan.dire.glm.root,'scan.mat'],'scan'); end
end
