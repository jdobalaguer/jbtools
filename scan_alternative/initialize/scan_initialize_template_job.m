
function job = scan_initialize_template_job(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    switch type
        case 'none'
            job = struct();
        case 'conversion'
            job = scan_initialize_template_job_conversion(type);
        case 'preprocess'
            job = scan_initialize_template_job_preprocess(type);
        case 'glm'
            job = scan_initialize_template_job_glm(type);
        case 'tbte'
            job = scan_initialize_template_job_tbte(type);
        case 'rsa'
            job = scan_initialize_template_job_rsa(type);
        otherwise
            warning('scan_job_template: error. type "%s" unknown',scan.job.type);
    end
end