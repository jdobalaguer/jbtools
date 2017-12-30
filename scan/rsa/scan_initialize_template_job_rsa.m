
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
    job.glm                = struct('type',{''},'name',{''},'condition',{{}},'image',{'beta'},'order',{[]});
    job.mask               = struct('type',{'individual'},'file',{'wholebrain.nii'});
    job.comparison         = 'spearman';
    job.distance           = 'euclidean';
    job.global             = 'none';
    job.loadRDM            = '';
    job.padSessions        = false;
    job.saveRDM            = false;
    job.searchlight        = [];
    job.transformation     = 'none';
    job.whatToDo           = 'all';
    job.whitening          = false;
    
    % model
    job.model = struct('name',{},'condition',{},'subname',{},'level',{},'function',{},'filter',{});
    
end
