
function scan = scan_autocomplete_rsa(scan)
    %% scan = SCAN_AUTOCOMPLETE_RSA(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % assert
    if strcmp(scan.job.glm.type,'glm') && ~isempty(cell_flat({scan.job.model.subname}))
        scan_tool_warning(scan,false,'conditions are not allowed with scan.job.glm.type = ''glm''');
        [scan.job.model.subname] = deal({});
        [scan.job.model.level] = deal({});
    end
    
    % job
    scan.running.directory.job = file_endsep(fullfile(scan.directory.(scan.job.type),scan.job.name));
    
    % glm
    scan.running.glm = file_loadvar(fullfile(scan.directory.(scan.job.glm.type),scan.job.glm.name,'scan.mat'),'scan');
    
    % load
    scan.running.load = struct();
    
    % mask
    scan.running.mask = struct('file',{},'mask',{},'shape',{});
    
    % model
    scan.running.model = struct('level',{},'column',{},'rdm',{});
    
    % toolbox
    scan.running.toolbox = {};
end
