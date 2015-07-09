
function scan = scan_mvpa_load(scan)
    %% scan = SCAN_MVPA_LOAD(scan)
    % load files for any scan_mvpa_ related analysis
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_uni
    %          scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % SPM toolbox
    if ~exist('spm.m','file'), spm8_add_paths(); end
    
    % load images
    scan = scan_mvpa_filename(scan);        % get beta files
    scan = scan_mvpa_image(scan);           % get images
    
    % apply mask
    scan = scan_mvpa_getmask(scan);         % get mask
    scan = scan_mvpa_mni2sub(scan);         % reverse normalization for subject
    scan = scan_mvpa_applymask(scan);       % apply mask
    scan = scan_mvpa_unnan(scan);           % remove nans
    
end
