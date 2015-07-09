
function scan = scan_mvpa_glmdx(scan)
    %% scan = SCAN_MVPA_GLMDX(scan)
    % runs a general linear model (GLM) first, then multi-voxel pattern analysis (MVPA) on top of the beta images
    % see also scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_dx
    %          scan_mvpa_dx_searchlight
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % assert
    assert(isfield(scan,'glm'),             'scan_mvpa_glmdx: error. glm not defined');
    assert( strcmp(scan.glm.function,'hrf'),'scan_mvpa_glmdx: error. this only works with glm.function = ''hrf''');
    assert(~scan.glm.pooling,               'scan_mvpa_glmdx: error. pooling forbidden');
    assert(isempty(scan.mvpa.glm),          'scan_mvpa_glmdx: error. mvpa.glm field must be empty');
    
    % GLM flags
    glm_redo = false(1,3);
    if isfield(scan.glm,'redo'), glm_redo(scan.glm.redo : end) = true; end
    do_glm_regressor   = glm_redo(1)  || ~exist(scan.dire.glm.regressor ,'dir');
    do_glm_regression  = glm_redo(2)  || ~exist(scan.dire.glm.firstlevel,'dir');
    do_glm_copy        = glm_redo(3)  || ~exist(scan.dire.glm.beta1,'dir');
    
    % MVPA flags
    mvpa_redo = false(1,4);
    if isfield(scan.glm,'redo'), mvpa_redo(scan.mvpa.redo : end) = true; end
    do_mvpa_image      = mvpa_redo(1);
    do_mvpa_regressor  = mvpa_redo(2);
    do_mvpa_mask       = mvpa_redo(3);
    do_mvpa_decoding   = mvpa_redo(4);
    
    % delete
    if do_glm_regressor   && exist(scan.dire.glm.regressor,  'dir'); rmdir(scan.dire.glm.regressor,  's'); end
    if do_glm_regression  && exist(scan.dire.glm.firstlevel, 'dir'); rmdir(scan.dire.glm.firstlevel, 's'); end
    if do_glm_regression  && exist(scan.dire.glm.beta1, 'dir');      rmdir(scan.dire.glm.beta1,      's'); end
    
    % SPM
    if ~exist('spm.m',      'file'), spm8_add_paths(); end
    spm_jobman('initcfg');
    
    % GENERAL LINEAR MODEL
    mkdirp(scan.dire.mvpa.glm);
    if do_glm_regressor,    scan = scan_glm_regressor_build(scan);  end    % REGRESSOR:    build
    if do_glm_regressor,    scan = scan_glm_regressor_check(scan);  end    % REGRESSOR:    check
    if do_glm_regression,   scan = scan_glm_first_design(scan);     end    % REGRESSION:   design
    if do_glm_regression,   scan = scan_glm_first_estimate(scan);   end    % REGRESSION:   estimate
    if do_glm_copy,         scan = scan_glm_copy_beta1(scan);       end    % COPY:         beta (first level)
    
    % MULTIVOXEL PATTERN ANALYSIS
    if do_mvpa_image
        scan = scan_mvpa_filename(scan);        % get beta files
        scan = scan_mvpa_image(scan);           % get images
        scan = scan_mvpa_glmdx_concat(scan);    % concatenate beta files and regressors
    end
    if do_mvpa_regressor,
        scan = scan_mvpa_regressor(scan);       % set regressors
        scan = scan_mvpa_discard(scan);         % discard beta images
    end
    if do_mvpa_mask,
        scan = scan_mvpa_getmask(scan);         % get mask
        scan = scan_mvpa_mni2sub(scan);         % reverse normalization for subject
        scan = scan_mvpa_applymask(scan);       % apply mask
        scan = scan_mvpa_unnan(scan);           % remove nans
    end
    if do_mvpa_decoding,
        scan = scan_mvpa_pooling(scan);         % merge all sessions
        scan = scan_mvpa_dx_list(scan);         % create a list of possible train/test combinations
        scan = scan_mvpa_dx_crossval(scan);     % cross-validation
        scan = scan_mvpa_dx_performance(scan);  % performance
        scan = scan_mvpa_dx_summarize(scan);    % summary
    end
end
