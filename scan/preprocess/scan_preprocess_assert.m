
function scan = scan_preprocess_assert(scan)
    %% scan = SCAN_PREPROCESS_ASSERT(scan)
    % preprocess assert
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<>

    %% FUNCTION
    
    % assert scan
    assert(isfield(scan,'preprocess'),  'scan_preprocess_run: error. no preprocess field');
    assert(iscell(scan.preprocess),     'scan_preprocess_run: error. "preprocess" field is not a cell');
    assert(~isempty(scan.preprocess),   'scan_preprocess_run: error. "preprocess" field is empty');
    assert(isstruct(scan.preprocess{1}), 'scan_preprocess_run: error. elements of "preprocess" are not structs');
    
    for i_job = 1:length(scan.preprocess)
        
        % assert job
        job = scan.preprocess{i_job};
        assert(isfield(job,'job'),  'scan_preprocess_run: error. job %d ill-defined',i_job);
        assert(isfield(job,'from'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
        assert(isfield(job.from,'path'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
        assert(isfield(job.from,'file'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
        if isfield(job,'move')
            assert(isfield(job.move,'path'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
            assert(isfield(job.move,'file'), 'scan_preprocess_run: error. job %d "%s" ill-defined',i_job,job.job);
        end
        
        % default
        if ~isfield(job,'run'),     job.run     = true;  end
        if ~isfield(job,'unzip'),   job.unzip   = false; end
        if ~isfield(job,'rmzip'),   job.rmzip   = false; end
        if ~isfield(job,'zip'),     job.zip     = false; end
        if ~isfield(job,'rm'),      job.rm      = false; end
        
        % set
        scan.preprocess{i_job} = job;
    end
end

