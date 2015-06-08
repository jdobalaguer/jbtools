
function scan = scan_initialize_autocomplete(scan)
    %% scan = SCAN_INITIALIZE_AUTOCOMPLETE(scan)
    % autocomplete initial values of [scan]
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % subject
    scan.running.subject.unique     = scan.subject.selection;
    if isempty(scan.running.subject.unique)
        scan.running.subject.unique = 1:length(scan.subject.session);
    end
    scan.running.subject.unique(ismember(scan.running.subject.unique,scan.subject.remove)) = [];
    scan.running.subject.number     = length(scan.running.subject.unique);
    scan.running.subject.session    = scan.subject.session(scan.running.subject.unique);
    
    % directory
    scan.running.directory.root    = scan.directory.root;
    
    % job stuff
    if ~any(strcmp(scan.job.type,{'conversion'}))
        scan.running.directory.job      = file_endsep(fullfile(scan.directory.(scan.job.type),scan.job.name));
        scan.running.file.save.scan     = [scan.running.directory.job,'scan.mat'];
        scan.running.file.save.caller   = [scan.running.directory.job,'caller.m'];
        scan.running.file.save.hdd      = [scan.running.directory.job,'hdd.mat'];
    end
end
