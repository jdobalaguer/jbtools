
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
    
    % assert scan
    assert(isfield(scan,'preprocess'),'scan_preprocess_run: error. no preprocess field');
    assert(isstruct(scan.preprocess), 'scan_preprocess_run: error. "preprocess" field is not a struct');
    
    for i_job = 1:length(scan.preprocess)
        
        % assert job
        job = scan.preprocess(i_job);
        assert(isfield(job,'job'),  'scan_preprocess_run: error. job %d ill-defined',i_job);
        assert(isfield(job,'from'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
        assert(isfield(job.from,'path'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
        assert(isfield(job.from,'file'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
        if isfield(job,'move')
            assert(isfield(job.move,'path'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
            assert(isfield(job.move,'file'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
        end
        if ~isfield(job,'run'),     job.run     = true;  end
        if ~isfield(job,'unzip'),   job.unzip   = false; end
        if ~isfield(job,'rmzip'),   job.rmzip   = false; end
        if ~isfield(job,'zip'),     job.zip     = false; end
        if ~isfield(job,'rm'),      job.rm      = false; end
        
        % unzip
        if job.unzip,           [scan,job] = scan_preprocess_unzip(scan,job); end
        % rmzip
        if job.rmzip,           [scan,job] = scan_preprocess_rmzip(scan,job); end
        % run job
        switch(job.job)
            case 'none'
            case 'despike'
                [scan,job] = scan_preprocess_despike(scan,job);
            case 'realignment'
                [scan,job] = scan_preprocess_realignment(scan,job);
            case 'coregistration'
                [scan,job] = scan_preprocess_coregistration(scan,job);
            case 'normalisation_str'
                [scan,job] = scan_preprocess_normalisation_str(scan,job);
            case 'normalisation_epi'
                [scan,job] = scan_preprocess_normalisation_epi(scan,job);
            case 'smoothing'
                [scan,job] = scan_preprocess_smoothing(scan,job);
            otherwise
                error('scan_preprocess_run: error. job "%s" unknown', job.job);
        end
        
        % move
        if isfield(job,'move'), [scan,job] = scan_preprocess_move(scan,job); end
        % zip
        if job.zip,             [scan,job] = scan_preprocess_zip(scan,job); end
        % rm
        if job.rm,              [scan,job] = scan_preprocess_remove(scan,job); end
    end
    
    % JOBS
    % % despike(                    'images',       'spikes',           '','g'                      );  % despike
    % % despike_move(               'images',       'spikes',           '','g'                      );  % despike           (move)
    % realignment_unwarp(         'images',       'realignment',      '', 'u'                     );  % realignment
    % compression(                'images'                                                        );  % image             (compression)
    % remove(                     'images'                                                        );  % image             (remove)
    % coregistration_str_meanepi( 'realignment',                      'u', 'c'                    );  % coregistration    (anatomical T1 to mean EPI)
    % normalisation_str_mni(                                          'c'                         );  % normalisation     (anatomical T1 to MNI template)
    % normalisation_epi_mni(      'realignment',  'normalisation',    'u', 'c'                    );  % normalisation     (EPI to MNI template)
    % compression(                'realignment'                                                   );  % realignment       (compression)
    % scan_clean(                 'nii3rea'                                                       );  % realignment       (clean)
    % smoothing(                  'normalisation','smooth'            ,sprintf('w%du',pars_voxs)  );  % smoothing
    % remove(                     'normalisation'                                                 );  % normalisation     (remove)


%     fprintf('Compression files for:    %s\n',dir_sub);
%     fprintf('Remove files for:    %s\n',dir_sub);
end

