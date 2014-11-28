
function scan = scan_rsa_deeye(scan)
    %% scan = SCAN_RSA_DEEYE(scan)
    % remove diagonal from RDM (RSA)
    % this is what you need if your regressors are temporally correlated
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.rsa.deeye, return; end
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.rdm), 'scan_rsa_deeye: error. number of subjects doesnt match');
    
    % deeye (remove the diagonal to control temporal correlations)
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        
        % load
        rdm = scan.rsa.variable.rdm{i_subject};
        n_beta = size(rdm,1);
        
        % set diagonal
        x = repmat(1:n_beta,[n_beta,1]);
        y = x';
        ii_diag = (abs(x-y) < scan.rsa.deeye);
        
        % rdm
        rdm(ii_diag(:)) = nan;
        scan.rsa.variable.rdm{i_subject} = rdm;
        
        if isfield(scan.rsa.variable,'model')
            % remove diagonal from models
            for i_model = 1:length(scan.rsa.variable.model{i_subject})
                scan.rsa.variable.model{i_subject}{i_model}.matrix(ii_diag) = 0;
            end

            % add diagonal model
            model.name   = 'diagonal';
            model.size   = n_beta;
            model.matrix = double(~ii_diag);
            scan.rsa.variable.model{i_subject}{end+1} = model;
        end
    end
end