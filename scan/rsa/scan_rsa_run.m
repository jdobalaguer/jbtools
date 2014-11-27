
function scan = scan_rsa_run(scan)
    %% scan = SCAN_MVPA_RSA(scan)
    % runs a multi-voxel pattern analysis (MVPA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_rsa_searchlight
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM toolbox
    if ~exist('spm.m',          'file'), spm8_add_paths(); end
    
    % run RSA
    scan = scan_rsa_filename(scan);     % get beta files
    scan = scan_rsa_mask(scan);         % load mask
    scan = scan_rsa_image(scan);        % load images
    scan = scan_rsa_unnan(scan);        % remove nans
    scan = scan_rsa_createrdm(scan);    % create RDM
    scan = scan_rsa_setmodel(scan);     % set models
    scan = scan_rsa_deeye(scan);        % de-eye RDM
    scan = scan_rsa_regress(scan);      % regression
    scan = scan_rsa_shrinkrdm(scan);    % shrink RDM
    scan = scan_rsa_plot_rdm(scan);     % plot RDM
    scan = scan_rsa_summarize(scan);    % summarize
    
end
