
function scan = scan_rsa_discard(scan)
    %% scan = SCAN_RSA_DISCARD(scan)
    % set discard indexes (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.file), 'scan_rsa_image: error. number of subjects doesnt match');
    
    % load images
    scan.rsa.variable.discard = {};
    for i_subject = 1:scan.subject.n
        
        % subject
        subject = scan.subject.u(i_subject);
        fprintf('scan_rsa: loading subject %02i: \n',subject);
        
        % numbers
        n_beta  = length(scan.rsa.variable.file{i_subject});
        
        % discarded images
        ii_subject = (scan.rsa.regressor.subject == subject);
        assert(sum(ii_subject)==n_beta, 'scan_rsa_image: error. number of subjects doesnt match');
        if isempty(scan.rsa.regressor.discard),
            ii_discard = false(size(ii_subject));
        else
            ii_discard = (scan.rsa.regressor.discard(ii_subject));
        end

        % save
        scan.rsa.variable.discard{i_subject} = ii_discard;
    end
end