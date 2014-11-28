
function scan = scan_rsa_createrdm(scan)
    %% scan = SCAN_RSA_CREATERDM(scan)
    % load images (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.beta), 'scan_rsa_createrdm: error. number of subjects doesnt match');
    
    % create rdm
    scan.rsa.variable.rdm = cell(1,scan.subject.n);
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('scan_rsa: create rdm %02i: \n',subject);
        switch(scan.rsa.distance)
            case 'pearson'
                scan.rsa.variable.rdm{i_subject} = 1-corr(scan.rsa.variable.beta{i_subject},'type','Pearson');
            case 'spearman'
                scan.rsa.variable.rdm{i_subject} = squareform(pdist(scan.rsa.variable.beta{i_subject}','spearman'));
            case 'manhattan'
                scan.rsa.variable.rdm{i_subject} = squareform(pdist(scan.rsa.variable.beta{i_subject}','minkowski',1));
            case 'euclidean'
                scan.rsa.variable.rdm{i_subject} = squareform(pdist(scan.rsa.variable.beta{i_subject}','euclidean'));
            case 'seuclidean'
                scan.rsa.variable.rdm{i_subject} = squareform(pdist(scan.rsa.variable.beta{i_subject}','seuclidean'));
            case 'cosine'
                scan.rsa.variable.rdm{i_subject} = squareform(pdist(scan.rsa.variable.beta{i_subject}','cosine'));
            case 'dot'
                scan.rsa.variable.rdm{i_subject} = 1./ (scan.rsa.variable.beta{i_subject}' * scan.rsa.variable.beta{i_subject});
            otherwise
                error('scan_rsa_createrdm: error. distance "%s" unknown',scan.rsa.distance);
        end
    end
end