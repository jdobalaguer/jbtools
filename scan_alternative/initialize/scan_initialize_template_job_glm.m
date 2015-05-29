
function job = scan_initialize_template_job_glm(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB_GLM(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    job.type       = type;
    job.name       = '';
    
    % settings
    job.copyFolder         = [0,1,0,0,0,1,1];
    job.delayOnset         = 0;
    job.functionBasis      = struct('name',{'fir'},'parameters',{struct('length',{14},'order',{8})});
    job.functionBasis      = struct('name',{'hrf'},'parameters',{struct('derivs',{[0,0]})});
    job.globalScaling      = false;
    job.image              = 'smooth';
    job.margeFromEnd       = 5;
    job.concatSessions     = false;
    job.restartFrom        = 'all';
    
    % conditions
    job.condition = struct('subject',{},'session',{},'onset',{},'discard',{},'name',{},'subname',{},'level',{},'duration',{});
    
    % regressor
    job.regressor = struct('name',{},'file',{},'type',{},'filter',{});
    
    % contrasts
    job.contrast.generic = true;
    job.contrast.extra   = struct('name',{},'condition',{},'weight',{});
    
end
