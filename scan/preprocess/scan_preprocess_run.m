
function scan = scan_preprocess_run(scan)
    %% scan = SCAN_PREPROCESS_RUN(scan)
    % pre-process 3d nifti files
    % see also scan_expand
    %          scan_glm_run
    %          scan_mvpa_run
    %          scan_rsa_run
    %          scan_dcm_run
    
    %% WARNINGS
    %#ok<>

    %% FUNCTION
    
    % SPM
    if ~exist('spm.m','file'), spm8_add_paths(); end
    spm_jobman('initcfg');
    
    % assert jobs
    scan = scan_preprocess_assert(scan);
    
    for i_job = 1:length(scan.preprocess)
        job = scan.preprocess{i_job};
        if job.unzip,           [scan,job] = scan_preprocess_unzip(scan,job); end   % unzip
        if job.rmzip,           [scan,job] = scan_preprocess_rmzip(scan,job); end   % rmzip
        switch(job.job)                                                             % run job
            case 'none'
            case 'despike',             [scan,job] = scan_preprocess_despike(scan,job);
            case 'slicetiming',         [scan,job] = scan_preprocess_slicetiming(scan,job);
            case 'realignment',         [scan,job] = scan_preprocess_realignment(scan,job);
            case 'coregistration',      [scan,job] = scan_preprocess_coregistration(scan,job);
            case 'normalisation_str',   [scan,job] = scan_preprocess_normalisation_str(scan,job);
            case 'normalisation_epi',   [scan,job] = scan_preprocess_normalisation_epi(scan,job);
            case 'smoothing',           [scan,job] = scan_preprocess_smoothing(scan,job);
            otherwise,                  error('scan_preprocess_run: error. job "%s" unknown', job.job);
        end
        if isfield(job,'move'), [scan,job] = scan_preprocess_move(scan,job); end    % move
        if job.zip,             [scan,job] = scan_preprocess_zip(scan,job); end     % zip
        if job.rm,              [scan,job] = scan_preprocess_remove(scan,job); end  % rm
    end
end

