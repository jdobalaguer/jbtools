
function scan = scan_mvpa_glm(scan)
    %% scan = SCAN_MVPA_GLM(scan)
    % runs a general linear model (GLM) for the multi-voxel pattern analysis (MVPA)
    %                                or for the representation similarity analysis (RSA)
    % see also scan_glm_run
    %          scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % assert
    assert(isfield(scan,'glm'),             'scan_mvpa_glm: error. glm not defined');
    assert( strcmp(scan.glm.function,'hrf'),'scan_mvpa_glm: error. this only works with glm.function = ''hrf''');
    assert(scan.glm.pooling,                'scan_mvpa_glm: error. pooling required');
    assert(~isempty(scan.mvpa.glm),          'scan_mvpa_glm: error. mvpa.glm field cannot be empty');
    
    % GLM flags
    redo = false(1,4);
    if isfield(scan.glm,'redo'), redo(scan.glm.redo : end) = true; end
    do_glm_regressor   = redo(1)  || ~exist(scan.dire.glm.regressor ,'dir');
    do_glm_regression  = redo(2)  || ~exist(scan.dire.glm.firstlevel,'dir');
    do_glm_firstlevel  = redo(3)  || ~exist(scan.dire.glm.firstlevel,'dir');
    do_glm_copy        = redo(4)  || ~exist(scan.dire.glm.beta1,'dir');
    
    % delete
    if do_glm_regressor   && exist(scan.dire.glm.regressor,  'dir'); rmdir(scan.dire.glm.regressor,  's'); end
    if do_glm_regression  && exist(scan.dire.glm.firstlevel, 'dir'); rmdir(scan.dire.glm.firstlevel, 's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.beta1,      'dir'); rmdir(scan.dire.glm.beta1,      's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.contrast1,  'dir'); rmdir(scan.dire.glm.contrast1,  's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.statistic1, 'dir'); rmdir(scan.dire.glm.statistic1, 's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.contrast1,  'dir'); rmdir(scan.dire.glm.contrast1,  's'); end
    if do_glm_firstlevel  && exist(scan.dire.glm.statistic1, 'dir'); rmdir(scan.dire.glm.statistic1, 's'); end
    
    % SPM
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
    
    if do_glm_copy,         scan = scan_glm_copy_split(scan);       save_scan(); end    % COPY:         beta (first level)
    
    %% AUXILIAR
    function save_scan()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, save([scan.dire.mvpa.glm,'scan.mat'],'scan'); end
    end
end
