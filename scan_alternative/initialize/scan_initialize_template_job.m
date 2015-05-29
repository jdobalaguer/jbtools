
function job = scan_initialize_template_job(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    switch type
        case 'dicom'
        case 'glm'
            job = scan_initialize_template_job_glm(type);
        case 'tbte'
        case 'mvpa'
        case 'rsa'
        otherwise
            warning('scan_job_template: error. type "%s" unknown',scan.job.type);
    end
end