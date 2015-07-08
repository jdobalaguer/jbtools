
function job = scan_initialize_template_job_conversion(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB_CONVERSION(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    job.type       = type;
    
    % setting
    job.whatToDo   = 'all';
end
