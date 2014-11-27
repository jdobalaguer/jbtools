
function scan_initialize_assert(scan)
    %% scan = SCAN_INITIALIZE_ASSERT(scan)
    % general struct sanity check
    % see also scan_initialize
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    assertWarning(isfield(scan,'pars'),                         'scan_initialize_assert: warning. scanner parameters havent been specified.');
    assertWarning(logical(exist(scan.dire.nii.root,'dir')),     'scan_initialize_assert: warning. folder "%s" doesnt exist',scan.dire.nii.root);
    assert(~strcmp(scan.dire.spm,'/'),                          'scan_initialize_assert: error. SPM is not added to the path.');

    if isfield(scan,'mvpa'), assert(~strcmp(strtrim(scan.mvpa.name),'glm'), 'scan_initialize_assert: error. mvpa.name cannot be "glm'); end
    if isfield(scan,'rsa'),  assert(~strcmp(strtrim(scan.rsa.name), 'glm'), 'scan_initialize_assert: error. rsa.name cannot be "glm');  end
end
