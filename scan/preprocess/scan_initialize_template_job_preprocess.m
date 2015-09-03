
function job = scan_initialize_template_job_preprocess(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB_PREPROCESS(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    job.type       = type;
    job.name       = '';
    
    % setting
    job.last                = struct('epi3',{'image'},'structural',{'image'});
    job.unwarp              = 'no';
    job.whatToDo            = 'all';
end
