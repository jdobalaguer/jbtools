
function job = scan_job_template(type)
    %% job = SCAN_JOB_TEMPLATE(type)
    % create job template
    % to list main functions, try
    %   >> scan;
    
    %% function
    switch type
        case 'dicom'
        case 'glm'
            job = scan_job_template_glm(type);
        case 'tbte'
        case 'mvpa'
        case 'rsa'
        otherwise
            warning('scan_job_template: error. type "%s" unknown',scan.job.type);
    end
end