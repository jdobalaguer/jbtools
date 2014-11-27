
function scan = scan_rsa_mask(scan)
    %% scan = SCAN_RSA_MASK(scan)
    % load mask (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % no mask
    if ~isfield(scan.rsa,'mask') || isempty(scan.rsa.mask),
        scan.rsa.variable.mask = [];
    % mask
    else
        scan.rsa.variable.mask = scan_nifti_load([scan.dire.mask,scan.rsa.mask]);
    end
end