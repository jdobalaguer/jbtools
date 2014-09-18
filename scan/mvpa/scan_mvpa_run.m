
function scan = scan_mvpa_run(scan)
    %% SCAN3_MVPA()
    % runs a multi-voxel pattern analysis (MVPA)
    % see also scan_initialize
    %          scan_preprocess_run
    %          scan_glm_run
    
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
    
    % MVPA flags
    mvpa_redo = true(1,1);
    if isfield(scan.mvpa,'redo'), mvpa_redo(1:scan.mvpa.redo-1) = false; end
    do_mvpa_multivoxel  = mvpa_redo(1) || ~exist(scan.dire.mvpa.root,'dir');
    
    % delete
    if do_glm_regressor   && exist(scan.dire.glm.regressor,  'dir'); rmdir(scan.dire.glm.regressor,  's'); end
    if do_glm_regression  && exist(scan.dire.glm.firstlevel, 'dir'); rmdir(scan.dire.glm.firstlevel, 's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.contrast1,  'dir'); rmdir(scan.dire.glm.statistic1,  's'); end
    if do_mvpa_multivoxel && exist(scan.dire.mvpa.mvpa,      'dir'); rmdir(scan.dire.mvpa.root,      's'); end
    
    % SPM and mvpa-toolbox
    if ~exist('spm.m',      'file'), spm8_add_paths(); end
    if ~exist('init_subj.m','file'), mvpa_add_paths(); end
    spm_jobman('initcfg');
    
    % create folder
    mkdirp(scan.dire.mvpa.root);
    save_scan();
    
    % 1 = glm
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
    
    % 2 = mvpa
    mkdirp(scan.dire.mvpa.mvpa);
    if do_mvpa_multivoxel,  scan = scan_mvpa_initialize(scan);      save_scan(); end    % MVPA:         initialize
    if do_mvpa_multivoxel,  scan = scan_mvpa_mask(scan);            save_scan(); end    % MVPA:         mask
    if do_mvpa_multivoxel,  scan = scan_mvpa_image(scan);           save_scan(); end    % MVPA:         image
    if do_mvpa_multivoxel,  scan = scan_mvpa_regressor(scan);       save_scan(); end    % MVPA:         regressor
    if do_mvpa_multivoxel,  scan = scan_mvpa_session(scan);         save_scan(); end    % MVPA:         session
    if do_mvpa_multivoxel,  scan = scan_mvpa_crossvalidation(scan); save_scan(); end    % MVPA:         cross-validation
    if do_mvpa_multivoxel,  scan = scan_mvpa_summarize(scan);       save_scan(); end    % MVPA:         summarize
    
    %% AUXILIAR
    function save_scan(), save([scan.dire.mvpa.root,'scan.mat'],'scan'); end
end
