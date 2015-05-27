
function job = scan_job_template_glm(type)
    %% job = SCAN_JOB_TEMPLATE_GLM(type)
    % create job template
    % to list main functions, try
    %   >> scan;
    
    %% function
    
    % job
    job.type       = type;
    job.name       = '';
    
    % settings
    job.copy       = [0,1,0,0,0,1,1];
    job.delay      = 0;
    job.function   = 'hrf';
    job.hrf.ord    = [0,0];
    job.fir        = struct('ord',8,'len',14);
    job.image      = 'smooth';
    job.marge      = 0;
    job.pooling    = false;
    job.redo       = 'all';
    
    % regressors
    job.regressor = struct('subject',{},'session',{},'onset',{},'discard',{},'name',{},'subname',{},'level',{},'duration',{});
    
    % contrasts
    job.contrasts.generic = true;
    job.contrasts.extra   = struct('name',{},'regressor',{},'weight',{});
end
