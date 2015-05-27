
function scan = scan_initialize_autocomplete(scan)
    %% scan = SCAN_INITIALIZE_AUTOCOMPLETE(scan)
    % autocomplete initial values of [scan]
    % to list main functions, try
    %   >> scan;
    
    %% function
    
    % subject
    scan.running.subject.unique = scan.subject.selection;
    scan.running.subject.unique(ismember(scan.running.subject.unique,scan.subject.remove)) = [];
    scan.running.subject.number = length(scan.running.subject.unique);
    
    scan.running.directory.job      = scan.directory.(scan.job.type);
    scan.running.file.save.scan     = [scan.running.directory.job,'scan.mat'];
    scan.running.file.save.caller   = [scan.running.directory.job,'caller.m'];
end
