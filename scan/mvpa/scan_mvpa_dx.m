
function scan = scan_mvpa_dx(scan)
    %% scan = SCAN_MVPA_DX(scan)
    % runs a multi-voxel pattern analysis (MVPA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM toolbox
    if ~exist('spm.m','file'), spm8_add_paths(); end
    
    % set regressors
    scan = scan_mvpa_regressor(scan);       % set regressors
    
    % load images
    scan = scan_mvpa_filename(scan);        % get beta files
    scan = scan_mvpa_mask(scan);            % load mask
    scan = scan_mvpa_mni2sub(scan);         % reverse normalization for subject
    scan = scan_mvpa_image(scan);           % load images
    scan = scan_mvpa_unnan(scan);           % remove nans
    
    % run MVPA
    scan = scan_mvpa_pooling(scan);         % merge all sessions
    scan = scan_mvpa_dx_list(scan);         % create a list of possible train/test combinations
    scan = scan_mvpa_dx_crossval(scan);     % cross-validation
    scan = scan_mvpa_dx_summarize(scan);    % summary
    
end
