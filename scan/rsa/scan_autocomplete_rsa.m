
function scan = scan_autocomplete_rsa(scan)
    %% scan = SCAN_AUTOCOMPLETE_RSA(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % assert
    if strcmp(scan.job.glm.type,'glm') && ~isempty(cell_flat({scan.job.model.subname}))
        scan_tool_warning(scan,true,'conditions are not allowed with scan.job.glm.type = ''glm''');
        [scan.job.model.subname] = deal({});
        [scan.job.model.level] = deal({});
    end
    
    % directory.job
    scan.running.directory.job       = file_endsep(fullfile(scan.directory.rsa,scan.job.glm.type,scan.job.glm.name,scan.job.name));
    
    % directory.save
    scan.running.directory.save.scan    = file_endsep(fullfile(scan.running.directory.job,'scan'));
    scan.running.directory.save.caller  = file_endsep(fullfile(scan.running.directory.job,'caller'));
    scan.running.file.save.hdd          = fullfile(scan.running.directory.job,'hdd.mat');
    
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
    
    % subject / session
    scan_tool_assert(scan,isequal(scan.running.subject.unique,scan.running.glm.running.subject.unique),'subjects in the GLM and the RSA must match (fix not implemented yet)');
    if struct_isfield(scan,'running.glm.job.concatSessions') && scan.running.glm.job.concatSessions
        scan.running.subject.session(:) = 1;
        scan_tool_warning(scan,true,'glm with concatenated sessions. will ignore [scan.subject.session]');
    end
    
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
