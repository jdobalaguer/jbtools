
function scan = scan_rsa_unnan(scan)
    %% scan = SCAN_RSA_UNNAN(scan)
    % remove nan from images (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.beta), 'scan_rsa_unnan: error. number of subjects doesnt match');
    
    % remove nan
    for i_subject = 1:scan.subject.n
        ii_nan = any(isnan(scan.rsa.variable.beta{i_subject}),2);
        scan.rsa.variable.beta{i_subject}(ii_nan,:) = [];
    end
end