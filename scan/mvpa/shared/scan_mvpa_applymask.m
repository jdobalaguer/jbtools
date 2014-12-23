
function scan = scan_mvpa_applymask(scan)
    %% scan = SCAN_MVPA_APPLYMASK(scan)
    % get mask
    % see also scan_mvpa_run
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.mask), 'scan_mvpa_applymask: error. number of subjects doesnt match');
    assert(scan.subject.n == length(scan.mvpa.variable.beta), 'scan_mvpa_applymask: error. number of subjects doesnt match');

    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        scan_mvpa_verbose(scan,sprintf('scan_mvpa: apply mask %02i:',subject));
        
        ii_mask = logical(scan.mvpa.variable.mask{i_subject}(:));
        scan.mvpa.variable.beta{i_subject}(~ii_mask,:) = [];
    end
end