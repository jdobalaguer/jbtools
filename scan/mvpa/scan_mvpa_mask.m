
function scan = scan_mvpa_mask(scan)
    %% scan = SCAN_MVPA_MASK(scan)
    % load mask
    % see also scan_mvpa_run
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % default
    if ~isfield(scan.mvpa,'mask')    scan.mvpa.mask = '';                                         end
    if ischar(scan.mvpa.mask),       scan.mvpa.mask = repmat({scan.mvpa.mask},[1,scan.subject.n]); end
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.mask), 'scan_mvpa_mask: error. number of subjects doesnt match');

    for i_subject = 1:scan.subject.n
        
        % no mask
        if isempty(scan.mvpa.mask{i_subject}),
            scan.mvpa.variable.mask{i_subject} = false(0,0,0);
            scan.mvpa.variable.size{i_subject} = [];
        
        % mask
        else
            [m,s] = scan_nifti_load([scan.dire.mask,scan.mvpa.mask{i_subject}]);
            scan.mvpa.variable.mask{i_subject} = m;
            scan.mvpa.variable.size{i_subject} = s;
        end
        
    end
end