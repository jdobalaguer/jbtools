
function scan_initialize_assert(scan)
    %% scan = SCAN_INITIALIZE_SET(scan)
    % general struct sanity check
    % see also scan_initialize
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    assertWarning(isfield(scan,'pars'),                         'scan_initialize_assert: warning. scanner parameters havent been specified.');
    assertWarning(~strcmp(scan.dire.spm,'/'),                   'scan_initialize_assert: warning. SPM is not added to the path.');
    assertWarning(logical(exist(scan.dire.nii.root,'dir')),     'scan_initialize_assert: warning. folder "%s" doesnt exist',scan.dire.nii.root);
end
