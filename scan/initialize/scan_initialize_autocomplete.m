
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
    
    % session
    scan.running.subject.session = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        session = scan.subject.session(scan.running.subject.unique(i_subject) == scan.subject.selection);
        if iscell(session), scan.running.subject.session(i_subject) = session;
        else                scan.running.subject.session{i_subject} = 1:session;
        end
    end
    
    % directory
    scan.running.directory.root    = scan.directory.root;
    
    % done
    scan.running.done = {};
end
