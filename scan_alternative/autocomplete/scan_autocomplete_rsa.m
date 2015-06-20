
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
    
    % directory.job
    scan.running.directory.job = file_endsep(fullfile(scan.directory.(scan.job.type),scan.job.name));
    
    % directory.map
    scan.running.directory.estimation.root          = file_endsep(fullfile(scan.running.directory.job,'estimation'));
    scan.running.directory.estimation.correlation   = file_endsep(fullfile(scan.running.directory.estimation.root,'correlation'));
    scan.running.directory.estimation.probability   = file_endsep(fullfile(scan.running.directory.estimation.root,'probability'));
    scan.running.directory.first.root               = file_endsep(fullfile(scan.running.directory.job,'first'));
    scan.running.directory.first.correlation        = file_endsep(fullfile(scan.running.directory.first.root,'correlation'));
    scan.running.directory.first.probability        = file_endsep(fullfile(scan.running.directory.first.root,'probability'));
    scan.running.directory.second.root              = file_endsep(fullfile(scan.running.directory.job,'second'));
    scan.running.directory.second.correlation       = file_endsep(fullfile(scan.running.directory.second.root,'correlation'));
    scan.running.directory.second.tStatistic        = file_endsep(fullfile(scan.running.directory.second.root,'tStatistic'));
    scan.running.directory.second.probability       = file_endsep(fullfile(scan.running.directory.second.root,'probability'));
    
    % glm
    scan.running.glm = scan_load_scan(scan,file_endsep(fullfile(scan.directory.(scan.job.glm.type),scan.job.glm.name,'scan')));
    
    % load
    scan.running.load = struct();
    
    % meta
    scan.running.meta = struct();
    
    % mask
    scan.running.mask = struct('file',{},'mask',{},'shape',{});
    
    % model
    scan.running.model = struct('name',{},'level',{},'column',{},'rdm',{});
    
    % toolbox
    scan.running.toolbox = {};
    
    % first
    scan.running.first = {};
end
