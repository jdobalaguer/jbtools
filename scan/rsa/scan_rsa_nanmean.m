
function scan = scan_rsa_nanmean(scan)
    %% scan = SCAN_RSA_NANMEAN(scan)
    % replace RDM cells with nans with the nanmean (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.rdm), 'scan_rsa_nanmean: error. number of subjects doesnt match');
    
    % deeye (remove the diagonal to control temporal correlations)
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        
        % load
        rdm = scan.rsa.variable.rdm{i_subject};
        % set nans
        ii_nan = isnan(rdm(:));
        
        % rdm
        rdm(ii_nan(:)) = nanmean(rdm(~ii_nan(:)));
        scan.rsa.variable.rdm{i_subject} = rdm;
    end
end