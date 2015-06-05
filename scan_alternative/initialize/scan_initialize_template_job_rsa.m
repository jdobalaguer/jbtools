
function job = scan_initialize_template_job_rsa(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB_RSA(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    job.type       = type;
    job.name       = '';
    
    % setting
    job.glm                = struct('type',{''},'name',{''},'order',{1});
    job.mask               = {''};
    job.distance           = 'euclidean';
    job.searchlight        = [];
    job.whatToDo           = 'all';
    
    % model
    job.model = struct('subject',{},'name',{},'matrix',{});
    
end
