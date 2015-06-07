
function job = scan_initialize_template_job_glm(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB_GLM(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    job.type       = type;
    job.name       = '';
    
    % setting
    job.concatSessions     = false;
    job.copyFolder         = {'beta_1','cont_1','spmt_1','spm_1','beta_2','cont_2','spmt_2','spm_2'};
    job.delayOnset         = 0;
    job.basisFunction      = struct('name',{},'parameters',{});
    job.globalScaling      = false;
    job.image              = 'smooth';
    job.margeFromEnd       = 0;
    job.secondLevel        = 'con';
    job.whatToDo           = 'all';
    
    % condition
    job.condition = struct('subject',{},'session',{},'onset',{},'discard',{},'name',{},'subname',{},'level',{},'duration',{});
    
    % regressor
    job.regressor = struct('name',{},'file',{},'type',{},'filter',{},'covariate',{});
    
    % ppi
    job.ppi = struct('name',{},'condition',{},'regressor',{},'order',{});
    
    % contrast
    job.contrast.generic = 1;
    job.contrast.extra   = struct('name',{},'column',{},'weight',{},'order',{});
    
end
