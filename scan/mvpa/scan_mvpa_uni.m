
function scan = scan_mvpa_uni(scan)
    %% scan = SCAN_MVPA_UNI(scan)
    % show univariate effects of data loaded with the MVPA scripts (helpful for debugging)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % SPM toolbox
    if ~exist('spm.m','file'), spm8_add_paths(); end
    
    % redo
    redo = true(1,4);
    if isfield(scan.mvpa,'redo'), redo(1:scan.mvpa.redo-1) = false; end
    do_image       = redo(1);
    do_regressor   = redo(2);
    do_mask        = redo(3);
    do_uni         = redo(4);
    
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
    
    % plot univariate levels
    if do_uni,
        scan = scan_mvpa_pooling(scan);         % merge all sessions
        scan = scan_mvpa_uni_mean(scan);        % set univariate values
        scan = scan_mvpa_uni_plot(scan);        % plot univariate effects
    end
    
end
