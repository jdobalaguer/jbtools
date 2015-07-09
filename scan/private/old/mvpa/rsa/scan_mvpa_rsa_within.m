
function scan = scan_mvpa_rsa_within(scan)
    %% scan = SCAN_MVPA_RSA_WITHIN(scan)
    % remove cells between sessions from RDM (RSA)
    % this is what you need to remove variance in patterns between sessions
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.mvpa.within, return; end
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.rdm), 'scan_rsa_within: error. number of subjects doesnt match');
    
    % deeye (remove the diagonal to control temporal correlations)
    for i_subject = 1:scan.subject.n
        
        % load
        rdm = scan.mvpa.variable.rdm{i_subject};
        n_beta = size(rdm,1);
        
        % set between sessions
        ii_session = scan.mvpa.variable.regressor{i_subject}{1}.session;
        scan.mvpa.variable.session{i_subject} = ii_session;
        x = repmat(ii_session,[n_beta,1]);
        y = x';
        ii_between = (x~=y);
        
        % rdm
        rdm(ii_between(:)) = nan;
        scan.mvpa.variable.rdm{i_subject} = rdm;
        
        if isfield(scan.mvpa.variable,'model')
            % remove diagonal from models
            for i_model = 1:length(scan.mvpa.variable.model{i_subject})
                scan.mvpa.variable.model{i_subject}{i_model}.matrix(ii_between) = 0;
            end

            % add diagonal model
            if scan.mvpa.pooling
                model.name   = 'within';
                model.session   = scan.mvpa.variable.model{i_subject}{1}.session;
                model.level     = nan(size(model.session));
                model.size   = n_beta;
                model.matrix = double(~ii_between);
                scan.mvpa.variable.model{i_subject}{end+1} = model;
            end
        end
    end
end