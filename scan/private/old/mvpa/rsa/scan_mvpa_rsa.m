
function scan = scan_mvpa_rsa(scan)
    %% scan = SCAN_MVPA_RSA(scan)
    % runs a representation similarity analysis (RSA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_dx
    
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
    do_rsa         = redo(4);
    
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
    
    % run RSA
    if do_rsa,
        scan = scan_mvpa_rsa_rdm(scan);         % create RDM
        scan = scan_mvpa_rsa_setmodel(scan);    % set models
        scan = scan_mvpa_rsa_deeye(scan);       % de-eye RDM
        scan = scan_mvpa_rsa_within(scan);      % remove between-sessions
        scan = scan_mvpa_rsa_nanmean(scan);     % replace nan with nanmean
        scan = scan_mvpa_pooling(scan);         % merge all sessions
        scan = scan_mvpa_rsa_regress(scan);     % regression
        scan = scan_mvpa_rsa_shrinkrdm(scan);   % shrink RDM
        scan = scan_mvpa_rsa_plot(scan);        % plot RDM
        scan = scan_mvpa_rsa_summarize(scan);   % summarize
    end
    
end
