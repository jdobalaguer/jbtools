
function job = scan_initialize_template_job(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if strcmp(type,'none')
        % type "none"
        job = struct();
    elseif file_exist(['scan_initialize_template_job_',type])
        % use appropiate template
        eval(sprintf('job = scan_initialize_template_job_%s(type);',type));
    else
        % no template found
        scan_tool_error(scan,'scan_job_template: error. type "%s" unknown',scan.job.type);
    end
end