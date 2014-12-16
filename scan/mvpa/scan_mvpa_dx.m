
function scan = scan_mvpa_dx(scan)
    %% scan = SCAN_MVPA_DX(scan)
    % runs a multi-voxel pattern analysis (MVPA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_rsa
    %          scan_mvpa_uni
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM toolbox
    if ~exist('spm.m','file'), spm8_add_paths(); end
    
    % redo
    redo = true(1,4);
    if isfield(scan.mvpa,'redo'), redo(1:scan.mvpa.redo-1) = false; end
    do_image       = redo(1);
    do_regressor   = redo(2);
    do_mask        = redo(3);
    do_decoding    = redo(4);
    
    % rmdir
    if do_mask, rmdirp(scan.dire.mvpa.mask); end
    
    % load images
    if do_image
        scan = scan_mvpa_filename(scan);        % get beta files
        scan = scan_mvpa_image(scan);           % get images
        scan = scan_mvpa_image_save(scan);      % save images
    else
        scan = scan_mvpa_image_load(scan);      % load images
    end
    
    % set regressors
    if do_regressor,
        scan = scan_mvpa_regressor(scan);       % set regressors
        scan = scan_mvpa_discard(scan);         % discard beta images
    end
    
    % apply mask
    if do_mask,
        scan = scan_mvpa_getmask(scan);         % get mask
        scan = scan_mvpa_mni2sub(scan);         % reverse normalization for subject
        scan = scan_mvpa_applymask(scan);       % apply mask
        scan = scan_mvpa_unnan(scan);           % remove nans
        scan = scan_mvpa_runmean(scan);         % average for each run
    end
    
    % decode
    if do_decoding,
        scan = scan_mvpa_pooling(scan);         % merge all sessions
        scan = scan_mvpa_dx_list(scan);         % create a list of possible train/test combinations
        scan = scan_mvpa_dx_crossval(scan);     % cross-validation
        scan = scan_mvpa_dx_performance(scan);  % performance
        scan = scan_mvpa_dx_summarize(scan);    % summary
    end
    
end
