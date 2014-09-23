
function scan = scan_mvpa_glm(scan)
    %% scan = SCAN_MVPA_GLM(scan)
    % runs a general linear model (GLM) for the multi-voxel pattern analysis (MVPA)
    % see also scan_glm_run
    %          scan_mvpa_run
    %          scan_mvpa_searchlight
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % GLM flags
    glm_redo = false(1,3);
    if isfield(scan,'glm')
        scan.glm.pooling = true;
        if isfield(scan.glm,'redo'), glm_redo(scan.glm.redo : end) = true; end
        do_glm_regressor   = glm_redo(1)  || ~exist(scan.dire.glm.regressor ,'dir');
        do_glm_regression  = glm_redo(2)  || ~exist(scan.dire.glm.firstlevel,'dir');
        do_glm_firstlevel  = glm_redo(3)  || ~exist(scan.dire.glm.firstlevel,'dir');
        % assert
        assert( strcmp(scan.glm.function,'hrf'),'scan_mvpa_run: error. this only works with glm.function = ''hrf''');
    else
        [do_glm_regressor,do_glm_regression,do_glm_firstlevel] = deal(false,false,false);
    end
    
    % delete
    if do_glm_regressor   && exist(scan.dire.glm.regressor,  'dir'); rmdir(scan.dire.glm.regressor,  's'); end
    if do_glm_regression  && exist(scan.dire.glm.firstlevel, 'dir'); rmdir(scan.dire.glm.firstlevel, 's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.beta1,      'dir'); rmdir(scan.dire.glm.beta1,      's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.contrast1,  'dir'); rmdir(scan.dire.glm.contrast1,  's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.statistic1, 'dir'); rmdir(scan.dire.glm.statistic1, 's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.contrast1,  'dir'); rmdir(scan.dire.glm.contrast1,  's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.statistic1, 'dir'); rmdir(scan.dire.glm.statistic1, 's'); end
    
    % SPM and mvpa-toolbox
    if ~exist('spm.m',      'file'), spm8_add_paths(); end
    spm_jobman('initcfg');
    
    % glm
    mkdirp(scan.dire.mvpa.glm);
    if do_glm_regressor,    scan = scan_glm_regressor_build(scan);  save_scan(); end    % REGRESSOR:    build
    if do_glm_regressor,    scan = scan_glm_regressor_check(scan);  save_scan(); end    % REGRESSOR:    check
    if do_glm_regressor,    scan = scan_glm_regressor_merge(scan);  save_scan(); end    % REGRESSOR:    merge
    if do_glm_regressor,    scan = scan_glm_regressor_split(scan);  save_scan(); end    % REGRESSOR:    split
    
    if do_glm_regression,   scan = scan_glm_first_design(scan);     save_scan(); end    % REGRESSION:   design
    if do_glm_regression,   scan = scan_glm_first_estimate(scan);   save_scan(); end    % REGRESSION:   estimate
    
    if do_glm_firstlevel,   scan = scan_glm_setcontrasts(scan);     save_scan(); end    % FIRST LEVEL:  set contrasts
    if do_glm_firstlevel,   scan = scan_glm_first_contrast(scan);   save_scan(); end    % FIRST LEVEL:  run contrasts and statistics
    
    if do_glm_firstlevel,   scan = scan_glm_copy_beta1(scan);       save_scan(); end    % COPY:         beta (first level)
    if do_glm_firstlevel,   scan = scan_glm_copy_contrast1(scan);   save_scan(); end    % COPY:         contrast (first level)
    if do_glm_firstlevel,   scan = scan_glm_copy_statistic1(scan);  save_scan(); end    % COPY:         statistic (first level)
    
    %% AUXILIAR
    function save_scan()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, save([scan.dire.mvpa.glm,'scan.mat'],'scan'); end
    end
end
