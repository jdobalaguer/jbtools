
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
    job.concatSessions     = false;
    job.glm                = struct('type',{''},'name',{''},'condition',{{}});
    job.mask               = struct('type',{'individual'},'file',{'wholebrain.nii'});
    job.distance           = 'seuclidean';
    job.comparison         = 'spearman';
    job.searchlight        = [];
    job.univariate         = false;
    job.whatToDo           = 'all';
    
    % filter
    job.filter = struct();
    
    % model
    job.model = struct('subject',{},'name',{},'matrix',{});
    
end
