
function scan = scan_mvpa_getmask(scan)
    %% scan = SCAN_MVPA_GETMASK(scan)
    % get mask
    % see also scan_mvpa_run
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % default
    if ~isfield(scan.mvpa,'mask')    scan.mvpa.mask = '';                                         end
    if ischar(scan.mvpa.mask),       scan.mvpa.mask = repmat({scan.mvpa.mask},[1,scan.subject.n]); end
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.mask), 'scan_mvpa_getmask: error. number of subjects doesnt match');

    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        scan_mvpa_verbose(scan,sprintf('scan_mvpa: get mask %02i:',subject));
        
        % no mask
        if isempty(scan.mvpa.mask{i_subject}),
            scan.mvpa.variable.mask{i_subject} = true(scan.mvpa.variable.size{i_subject});
        
        % mask
        else
            [m,s] = scan_nifti_load([scan.dire.mask,scan.mvpa.mask{i_subject}]);
            if ~scan.mvpa.mni
                assert(all(scan.mvpa.variable.size{i_subject} == s), 'scan_mvpa_getmask: error. mask size doesnt match images size');
            else
                warning('scan_mvpa_getmask: warning. TODO - assert it matches the normalised MNI space');
            end
            m(isnan(m(:))) = 0;
            m = logical(m);
            scan.mvpa.variable.mask{i_subject} = m;
        end
        
    end
end