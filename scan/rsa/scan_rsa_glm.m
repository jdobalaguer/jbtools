
function scan = scan_rsa_glm(scan)
    %% scan = SCAN_RSA_GLM(scan)
    % runs a general linear model (GLM) for the representation similarity analysis (RSA)
    % see also scan_glm_run
    %          scan_rsa_run
    %          scan_rsa_searchlight
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % flags
    glm_redo = true(1,2);
    if isfield(scan.glm,'redo'), glm_redo(1:scan.glm.redo-1) = false; end
    do_glm_regressor   = glm_redo(1)  || ~exist(scan.dire.glm.regressor ,'dir');
    do_glm_regression  = glm_redo(2)  || ~exist(scan.dire.glm.firstlevel,'dir');
    do_glm_copy        = glm_redo(3)  || ~exist(scan.dire.glm.beta1     ,'dir');
    
    % assert
    assert( strcmp(scan.glm.function,'hrf'),'scan_rsa_glm: error. this only works with glm.function = ''hrf''');

    % delete
    if do_glm_regressor   && exist(scan.dire.glm.regressor,  'dir'); rmdir(scan.dire.glm.regressor,  's'); end
    if do_glm_regression  && exist(scan.dire.glm.firstlevel, 'dir'); rmdir(scan.dire.glm.firstlevel, 's'); end
    if do_glm_copy        && exist(scan.dire.glm.beta1,      'dir'); rmdir(scan.dire.glm.beta1,      's'); end
    
    % SPM
    if ~exist('spm.m',      'file'), spm8_add_paths(); end
    spm_jobman('initcfg');
    
    % glm
    mkdirp(scan.dire.rsa.glm);
    if do_glm_regressor,    scan = scan_glm_regressor_build(scan);  save_scan(); end    % REGRESSOR:    build
    if do_glm_regressor,    scan = scan_glm_regressor_check(scan);  save_scan(); end    % REGRESSOR:    check
    if do_glm_regressor,    scan = scan_glm_regressor_merge(scan);  save_scan(); end    % REGRESSOR:    merge
    if do_glm_regression,   scan = scan_glm_first_design(scan);     save_scan(); end    % REGRESSION:   design
    if do_glm_regression,   scan = scan_glm_first_estimate(scan);   save_scan(); end    % REGRESSION:   estimate
    if do_glm_copy,         scan = scan_glm_copy_beta1(scan);       save_scan(); end    % COPY:         beta
    
    %% AUXILIAR
    function save_scan()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, save([scan.dire.rsa.root,'scan.mat'],'scan'); end
    end
end
