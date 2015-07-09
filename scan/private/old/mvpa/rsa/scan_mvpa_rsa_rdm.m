
function scan = scan_mvpa_rsa_rdm(scan)
    %% scan = SCAN_MVPA_RSA_RDM(scan)
    % set the main temporal RDM (RSA)
    % see also scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.beta), 'scan_mvpa_rsa_rdm: error. number of subjects doesnt match');
    
    % create rdm
    scan.mvpa.variable.rdm = cell(1,scan.subject.n);
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('scan_mvpa: create rdm %02i: \n',subject);
        beta = cell2mat(scan.mvpa.variable.beta(i_subject,:))';
        switch(scan.mvpa.distance)
            case 'pearson'
                scan.mvpa.variable.rdm{i_subject} = 1-corr(beta,'type','Pearson');
            case 'spearman'
                scan.mvpa.variable.rdm{i_subject} = squareform(pdist(beta,'spearman'));
            case 'manhattan'
                scan.mvpa.variable.rdm{i_subject} = squareform(pdist(beta,'minkowski',1));
            case 'euclidean'
                scan.mvpa.variable.rdm{i_subject} = squareform(pdist(beta,'euclidean'));
            case 'seuclidean'
                scan.mvpa.variable.rdm{i_subject} = squareform(pdist(beta,'seuclidean'));
            case 'cosine'
                scan.mvpa.variable.rdm{i_subject} = squareform(pdist(beta,'cosine'));
            case 'univariate'
                 scan.mvpa.variable.rdm{i_subject} = squareform(pdist(mean(beta,2),'euclidean'));
            case 'dot'
                scan.mvpa.variable.rdm{i_subject} = 1./ (beta * beta');
            otherwise
                error('scan_mvpa_rsa_rdm: error. distance "%s" unknown',scan.mvpa.distance);
        end
    end
end