
function scan = scan_mvpa_rsa_searchlight(scan)
    %% scan = SCAN_MVPA_RSA_SEARCHLIGHT(scan)
    % runs a representation similarity analysis with searchlight (RSA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_run
    %          scan_mvpa_glm
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM toolbox
    if ~exist('spm.m','file'), spm8_add_paths(); end
    
    % load images
    scan = scan_mvpa_filename(scan);            % get beta files
    scan = scan_mvpa_mask(scan);                % load mask
    scan = scan_mvpa_image(scan);               % load images
    scan = scan_mvpa_unnan(scan);               % remove nans
    
    % run RSA within each sphere
    scan = scan_rsa_searchlight_sphere(scan);   % set spheres
    
    %%
    return;
    for i_sphere = 1:length(scan.mvpa.variable.sphere)
        scan = scan_mvpa_rsa_rdm(scan);         % create RDM
        scan = scan_mvpa_rsa_setmodel(scan);    % set models
        scan = scan_mvpa_rsa_deeye(scan);       % de-eye RDM
        scan = scan_mvpa_rsa_regress(scan);     % regression
        scan = scan_mvpa_rsa_summarize(scan);   % summarize
    end
    
    % normalize and smooth maps
    scan = scan_mvpa_searchlight_normalize(scan);        % normalization
    scan = scan_mvpa_searchlight_smooth(scan);           % smoothing
    scan = scan_mvpa_searchlight_second_contrast(scan);  % second level contrast (between participants)
    
end
