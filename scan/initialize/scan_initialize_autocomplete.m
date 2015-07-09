
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
    
    % done
    scan.running.done = {};
end
