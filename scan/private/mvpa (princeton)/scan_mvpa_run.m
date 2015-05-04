
function scan = scan_mvpa_run(scan)
    %% scan = SCAN_MVPA_RUN(scan)
    % runs a multi-voxel pattern analysis (MVPA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_searchlight
    
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
    mvpa_redo = true(1,3);
    if isfield(scan.mvpa,'redo'), mvpa_redo(1:scan.mvpa.redo-1) = false; end
    do_mvpa_images      = mvpa_redo(1) || ~exist([scan.dire.mvpa.root,'images.mat'],'file');
    do_mvpa_multivoxel  = mvpa_redo(2) || ~exist([scan.dire.mvpa.root,'results.mat'],'file');
    do_mvpa_summarize   = mvpa_redo(3);
    % delete
    if do_mvpa_images && exist(scan.dire.mvpa.mvpa,'dir'); rmdir(scan.dire.mvpa.root,'s'); end
    
    % SPM and mvpa-toolbox
    if ~exist('spm.m',      'file'), spm8_add_paths(); end
    if ~exist('init_subj.m','file'), mvpa_add_paths(); end
    
    % create folder
    mkdirp(scan.dire.mvpa.root);
    mkdirp(scan.dire.mvpa.mvpa);
                             scan = scan_mvpa_variable(scan,'run');
    if  do_mvpa_images,      scan = scan_mvpa_initialize(scan);      save_scan(); end    % MVPA:         initialize
    if  do_mvpa_images,      scan = scan_mvpa_mask(scan);            save_scan(); end    % MVPA:         mask
    if  do_mvpa_images,      scan = scan_mvpa_image(scan);           save_scan(); end    % MVPA:         image
    if  do_mvpa_images,                                            save_images(); end    % SAVE:         images
    if ~do_mvpa_images && do_mvpa_multivoxel,                      load_images(); end    % LOAD:         images
    if  do_mvpa_multivoxel,  scan = scan_mvpa_regressor(scan);       save_scan(); end    % MVPA:         regressor
    if  do_mvpa_multivoxel,  scan = scan_mvpa_selector(scan);        save_scan(); end    % MVPA:         selector
    if  do_mvpa_multivoxel,  scan = scan_mvpa_zscore(scan);          save_scan(); end    % MVPA:         z-score
    if  do_mvpa_multivoxel,  scan = scan_mvpa_index(scan);           save_scan(); end    % MVPA:         index
    if  do_mvpa_multivoxel,  scan = scan_mvpa_statmap(scan);         save_scan(); end    % MVPA:         statmap
    if  do_mvpa_multivoxel,  scan = scan_mvpa_crossvalidation(scan); save_scan(); end    % MVPA:         cross-validation
    if  do_mvpa_multivoxel,                                       save_results(); end    % SAVE:         results
    if ~do_mvpa_multivoxel && do_mvpa_summarize,                  load_results(); end    % LOAD:         results
    if  do_mvpa_summarize,   scan = scan_mvpa_summarize(scan);                    end    % MVPA:         summarize
    
    %% AUXILIAR
    function save_scan()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, save([scan.dire.mvpa.root,'scan.mat'],'scan'); end
    end
    function save_images()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, save([scan.dire.mvpa.root,'images.mat'],'scan'); end
    end
    function load_images()
        loading = load([scan.dire.mvpa.root,'images.mat'],'scan');
        scan.mvpa.subject = loading.scan.mvpa.subject;
    end
    function save_results()
        whos_scan = whos('scan');
        if whos_scan.bytes < 2e9, save([scan.dire.mvpa.root,'results.mat'],'scan'); end
    end
    function load_results()
        results = load([scan.dire.mvpa.root,'results.mat'],'scan');
        scan = results.scan;
    end
    
end
