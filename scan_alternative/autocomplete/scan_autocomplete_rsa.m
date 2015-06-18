
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
    scan.running.directory.map.root = file_endsep(fullfile(scan.running.directory.job,'map'));
    scan.running.directory.map.model   = cell(1,numel(scan.job.model));
    scan.running.directory.map.subject = cell(1,numel(scan.job.model));
    scan.running.directory.map.session = cell(1,numel(scan.job.model));
    for i_model = 1:numel(scan.job.model);
        scan.running.directory.map.model  {i_model} = file_endsep(fullfile(scan.running.directory.map.root,scan.job.model(i_model).name));
        scan.running.directory.map.subject{i_model} = cell(1,numel(scan.running.subject.number));
        scan.running.directory.map.session{i_model} = cell(1,numel(scan.running.subject.number));
        for i_subject = 1:scan.running.subject.number
            scan.running.directory.map.subject{i_model}{i_subject} = file_endsep(fullfile(scan.running.directory.map.model{i_model},scan.parameter.path.subject{i_subject}));
            for i_session = 1:scan.running.subject.session(i_subject)
                scan.running.directory.map.session{i_model}{i_subject}{i_session} = file_endsep(fullfile(scan.running.directory.map.subject{i_model}{i_subject},scan.parameter.path.session{i_session}));
            end
        end
    end
    
    % glm
    scan.running.glm = file_loadvar(fullfile(scan.directory.(scan.job.glm.type),scan.job.glm.name,'scan.mat'),'scan');
    
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
end
