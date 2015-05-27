
function scan = scan_initialize_autocomplete_glm(scan)
    %% scan = SCAN_INITIALIZE_AUTOCOMPLETE_GLM(scan)
    % autocomplete initial values of for [scan.job.type = 'glm']
    % to list main functions, try
    %   >> scan;
    
    %% notes
    % we could specify a second input that only includes the name of the glm, or scan.directory.glm ?
    
    %% function
    
    % subject
    scan.running.directory.job = [scan.directory.(scan.job.type),scan.job.name,filesep];
    scan.running.directory.original.regressor    = [scan.running.directory.job,'original',filesep,'regressor',filesep];
    scan.running.directory.original.first        = [scan.running.directory.job,'original',filesep,'first_level',filesep];
    scan.running.directory.original.second       = [scan.running.directory.job,'original',filesep,'second_level',filesep];
    scan.running.directory.copy.first.beta       = [scan.running.directory.job,'copy',filesep,'beta_1',filesep];
    scan.running.directory.copy.first.contrast   = [scan.running.directory.job,'copy',filesep,'cont_1',filesep];
    scan.running.directory.copy.first.statistic  = [scan.running.directory.job,'copy',filesep,'spmt_1',filesep];
    scan.running.directory.copy.second.beta      = [scan.running.directory.job,'copy',filesep,'beta_2',filesep];
    scan.running.directory.copy.second.contrast  = [scan.running.directory.job,'copy',filesep,'cont_2',filesep];
    scan.running.directory.copy.second.statistic = [scan.running.directory.job,'copy',filesep,'spmt_2',filesep];
    
    
end