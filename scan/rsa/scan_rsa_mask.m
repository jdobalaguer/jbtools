
function scan = scan_rsa_mask(scan)
    %% scan = SCAN_RSA_MASK(scan)
    % load mask (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % default
    if ~isfield(scan.rsa,'mask')    scan.rsa.mask = '';                                         end
    if ischar(scan.rsa.mask),       scan.rsa.mask = repmat({scan.rsa.mask},[1,scan.subject.n]); end
    
    % assert
    assert(scan.subject.n == length(scan.rsa.mask), 'scan_rsa_mask: error. number of subjects doesnt match');

    for i_subject = 1:scan.subject.n
        
        % no mask
        if isempty(scan.rsa.mask{i_subject}),
            scan.rsa.variable.mask{i_subject} = false(0,0,0);
            scan.rsa.variable.size{i_subject} = [];
        
        % mask
        else
            [m,s] = scan_nifti_load([scan.dire.mask,scan.rsa.mask{i_subject}]);
            scan.rsa.variable.mask{i_subject} = m;
            scan.rsa.variable.size{i_subject} = s;
        end
        
    end
end