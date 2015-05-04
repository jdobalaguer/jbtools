
function scan = scan_ppi_run(scan)
    %% scan = SCAN_PPI_RUN(scan)
    % runs a Psycho Physical Interaction (PPI) analysis
    % see also scan_initialize
    %          scan_preprocess_run
    %          scan_mvpa_run

    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM
    if ~exist('spm.m','file'), spm8_add_paths(); end
    spm_jobman('initcfg');
    mkdirp(scan.dire.ppi.root);
    mkdirp(scan.dire.glm.root);
    
    % GLM design automation
    scan = scan_ppi_glm_init(scan);
    scan = scan_ppi_glm_design(scan);
    
    % add seed activity
    scan = scan_ppi_seed(scan);
    scan = scan_ppi_pooling(scan);
    scan = scan_ppi_filter(scan);
    scan = scan_ppi_zscore(scan);
    scan = scan_ppi_append(scan);
    
    % set contrasts
    if ~scan.ppi.do.seed,
        tmp = load([scan.dire.glm.root,'scan.mat']);
        tmp = tmp.scan;
        scan.ppi.variables = tmp.ppi.variables;
    end
    scan = scan_glm_setcontrasts(scan);
    scan = scan_ppi_setcontrasts(scan);
    
    % run the GLM
    scan = scan_ppi_glm_estimation(scan);
    scan = scan_ppi_glm_end(scan);
    
end
