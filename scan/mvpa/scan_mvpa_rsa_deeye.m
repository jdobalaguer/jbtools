
function scan = scan_mvpa_rsa_deeye(scan)
    %% scan = SCAN_MVPA_RSA_DEEYE(scan)
    % remove diagonal from RDM (RSA)
    % this is what you need if your regressors are temporally correlated
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.mvpa.deeye, return; end
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.rdm), 'scan_mvpa_rsa_deeye: error. number of subjects doesnt match');
    
    % deeye (remove the diagonal to control temporal correlations)
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        
        % load
        rdm = scan.mvpa.variable.rdm{i_subject};
        n_beta = size(rdm,1);
        
        % set diagonal
        x = repmat(1:n_beta,[n_beta,1]);
        y = x';
        ii_diag = (abs(x-y) < scan.mvpa.deeye);
        
        % rdm
        rdm(ii_diag(:)) = nan;
        scan.mvpa.variable.rdm{i_subject} = rdm;
        
        if isfield(scan.mvpa.variable,'model')
            % remove diagonal from models
            for i_model = 1:length(scan.mvpa.variable.model{i_subject})
                scan.mvpa.variable.model{i_subject}{i_model}.matrix(ii_diag) = 0;
            end

            % add diagonal model
            model.name      = 'diagonal';
            model.session   = scan.mvpa.variable.model{i_subject}{1}.session;
            model.level     = nan(size(model.session));
            model.size      = n_beta;
            model.matrix    = double(~ii_diag);
            scan.mvpa.variable.model{i_subject}{end+1} = model;
        end
    end
end