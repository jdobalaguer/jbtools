
function scan = scan_mvpa_searchlight(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT(scan)
    % runs a multi-voxel pattern analysis with searchlight (MVPA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_run
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION

    % assert GLM
    if ~(exist(scan.dire.mvpa.glm,'dir'))
        cprintf([1,0,0],'scan_mvpa_run: error. no GLM folder              \n');
        cprintf([1,0,0],'scan_mvpa_run: error. please see "scan_mvpa_glm" \n');
        return;
    end
    
    % flags
    mvpa_redo = true(1,2);
    if isfield(scan.mvpa,'redo'), mvpa_redo(1:scan.mvpa.redo-1) = false; end
    do_mvpa_loading     = mvpa_redo(1) || ~exist([scan.dire.mvpa.root,'image.mat'],'file');
    do_mvpa_multivoxel  = mvpa_redo(2) || ~exist(scan.dire.mvpa.root,'dir');
    
    % delete
    if do_mvpa_loading && exist(scan.dire.mvpa.mvpa,'dir'); rmdir(scan.dire.mvpa.root,'s'); end
    
    % SPM and mvpa-toolbox
    if ~exist('spm.m',      'file'), spm8_add_paths(); end
    if ~exist('init_subj.m','file'), mvpa_add_paths(); end
    
    % create folders
    mkdirp(scan.dire.mvpa.root);
    mkdirp(scan.dire.mvpa.mvpa);
                             scan = scan_mvpa_variable(scan,'searchlight');
    if  do_mvpa_loading,     scan = scan_mvpa_initialize(scan);      save_scan(); end    % LOAD:         initialize
    if  do_mvpa_loading,     scan = scan_mvpa_mask(scan);            save_scan(); end    % LOAD:         mask
    if  do_mvpa_loading,     scan = scan_mvpa_image(scan);           save_scan(); end    % LOAD:         image
    if  do_mvpa_loading,                                          save_loading(); end    % LOAD:         save
    if ~do_mvpa_loading,                                          load_loading(); end    % LOAD:         load
    
    if do_mvpa_multivoxel,   scan = scan_mvpa_regressor(scan);       save_scan(); end    % MVPA:         regressor
    if do_mvpa_multivoxel,   scan = scan_mvpa_selector(scan);        save_scan(); end    % MVPA:         selector
    if do_mvpa_multivoxel,   scan = scan_mvpa_zscore(scan);          save_scan(); end    % MVPA:         z-score
    if do_mvpa_multivoxel,   scan = scan_mvpa_sl_selector(scan);     save_scan(); end    % MVPA:         searchlight selector
    if do_mvpa_multivoxel,   scan = scan_mvpa_sl_adjency(scan);      save_scan(); end    % MVPA:         searchlight adjency
    if do_mvpa_multivoxel,   scan = scan_mvpa_statmap(scan);         save_scan(); end    % MVPA:         statmap
    if do_mvpa_multivoxel,   scan = scan_mvpa_sl_sortedmask(scan);   save_scan(); end    % MVPA:         searchlight sorted mask
    if do_mvpa_multivoxel,   scan = scan_mvpa_sl_dummyswitch(scan);  save_scan(); end    % MVPA:         dummy selector
    if do_mvpa_multivoxel,   scan = scan_mvpa_crossvalidation(scan); save_scan(); end    % MVPA:         cross-validation
    if do_mvpa_multivoxel,   scan = scan_mvpa_summarize(scan);       save_scan(); end    % MVPA:         summarize
    
    %% AUXILIAR
    function save_scan()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, save([scan.dire.mvpa.root,'scan.mat'],'scan'); end
    end
    function save_loading()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, save([scan.dire.mvpa.root,'image.mat'],'scan'); end
    end
    function load_loading()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, loading = load([scan.dire.mvpa.root,'image.mat'],'scan'); scan.mvpa.subject = loading.scan.mvpa.subject; end
    end
    end
