
function job = scan_initialize_template_job_tbte(type)
    %% job = SCAN_INITIALIZE_TEMPLATE_JOB_TBTE(type)
    % create job template
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    job.type       = type;
    job.name       = '';
    
    % setting
    job.copyFolder         = {'beta_1'};
    job.delayOnset         = 0;
    job.functionBasis      = struct('name',{'hrf'},'parameters',{struct('derivs',{[0,0]})});
    job.globalScaling      = false;
    job.image              = 'smooth';
    job.margeFromEnd       = 0;
    job.restartFrom        = 'design';
    
    % condition
    job.condition = struct('subject',{},'session',{},'onset',{},'discard',{},'name',{},'duration',{});
    
    % regressor
    job.regressor = struct('name',{},'file',{},'type',{},'filter',{},'covariate',{});
end
