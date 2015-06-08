
function job = scan_initialize_template_job_preprocess(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB_PREPROCESS(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % add extra options here, like slice-time correction etc...
    
    %% function
    
    % job
    job.type       = type;
    job.name       = '';
    
    % setting
    job.whatToDo   = 'all';
    scan.job.sliceTimeCorrection = false;
end
