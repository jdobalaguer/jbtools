
function scan = scan_rsa_within(scan)
    %% scan = SCAN_RSA_WITHIN(scan)
    % remove cells between sessions from RDM (RSA)
    % this is what you need to remove variance in patterns between sessions
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.rsa.within, return; end
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.rdm), 'scan_rsa_within: error. number of subjects doesnt match');
    
    % deeye (remove the diagonal to control temporal correlations)
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        
        % load
        rdm = scan.rsa.variable.rdm{i_subject};
        n_beta = size(rdm,1);
        
        % set between sessions
        ii_session = scan.rsa.regressor.session(scan.rsa.regressor.subject == subject);
        ii_discard = scan.rsa.variable.discard{i_subject};
        ii_session = ii_session(~ii_discard);
        assert(length(scan.rsa.regressor.session(ii_session)) == n_beta, 'scan_rsa_within: error. length of sacn.rsa.regressor.session doesnt match');
        scan.rsa.variable.session{i_subject} = ii_session;
        x = repmat(ii_session,[n_beta,1]);
        y = x';
        ii_between = (x~=y);
        
        % rdm
        rdm(ii_between(:)) = nan;
        scan.rsa.variable.rdm{i_subject} = rdm;
        
        if isfield(scan.rsa.variable,'model')
            % remove diagonal from models
            for i_model = 1:length(scan.rsa.variable.model{i_subject})
                scan.rsa.variable.model{i_subject}{i_model}.matrix(ii_between) = 0;
            end

            % add diagonal model
            if scan.rsa.pooling
                model.name   = 'within';
                model.size   = n_beta;
                model.matrix = double(~ii_between);
                scan.rsa.variable.model{i_subject}{end+1} = model;
            end
        end
    end
end