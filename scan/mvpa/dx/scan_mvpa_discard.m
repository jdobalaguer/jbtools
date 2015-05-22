
function scan = scan_mvpa_discard(scan)
    %% scan = SCAN_MVPA_DISCARD(scan)
    % discard images
    % see also scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % discard
    for i_subject = 1:scan.subject.n
        assert(size(scan.mvpa.variable.beta{i_subject},2) == length(scan.mvpa.variable.regressor{i_subject}{1}.discard), 'scan_mvpa_discard: error. unconsistent discard');
        scan.mvpa.variable.beta{i_subject}(:,scan.mvpa.variable.regressor{i_subject}{1}.discard) = [];
    end
    
    % assert
    for i_subject = 1:scan.subject.n
        assert(size(scan.mvpa.variable.beta{i_subject},2) == length(scan.mvpa.variable.regressor{i_subject}{1}.session),'scan_mvpa_discard: error. unconsistent session');
    end
    
end
