
function scan = scan_mvpa_rsa_nanmean(scan)
    %% scan = SCAN_MVPA_RSA_NANMEAN(scan)
    % replace RDM cells with nans with the nanmean (RSA)
    % see also scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.rdm), 'scan_mvpa_rsa_nanmean: error. number of subjects doesnt match');
    
    % deeye (remove the diagonal to control temporal correlations)
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        
        % load
        rdm = scan.mvpa.variable.rdm{i_subject};
        % set nans
        ii_nan = isnan(rdm(:));
        
        % rdm
        rdm(ii_nan(:)) = nanmean(rdm(~ii_nan(:)));
        scan.mvpa.variable.rdm{i_subject} = rdm;
    end
end