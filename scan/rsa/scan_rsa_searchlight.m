
function scan = scan_rsa_searchlight(scan)
    %% scan = SCAN_RSA_SEARCHLIGHT(scan)
    % runs a representation similarity analysis with searchlight (RSA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_run
    %          scan_mvpa_glm
    %          scan_rsa_run
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM toolbox
    if ~exist('spm.m','file'), spm8_add_paths(); end
    
    % load images
    scan = scan_rsa_filename(scan);             % get beta files
    scan = scan_rsa_mask(scan);                 % load mask
    scan = scan_rsa_image(scan);                % load images
    scan = scan_rsa_unnan(scan);                % remove nans
    
    % run RSA within each sphere
    scan = scan_rsa_sl_sphere(scan);            % set spheres
    
    %%
    return;
    for i_sphere = 1:length(scan.rsa.variable.sphere)
        scan = scan_rsa_createrdm(scan);        % create RDM
        scan = scan_rsa_setmodel(scan);         % set models
        scan = scan_rsa_deeye(scan);            % de-eye RDM
        scan = scan_rsa_regress(scan);          % regression
        scan = scan_rsa_summarize(scan);        % summarize
    end
    
    % normalize and smooth maps
    scan = scan_rsa_sl_normalize(scan);         % normalization
    scan = scan_rsa_sl_smooth(scan);            % smoothing
    scan = scan_rsa_sl_second_contrast(scan);   % second level contrast (between participants)
    
end
