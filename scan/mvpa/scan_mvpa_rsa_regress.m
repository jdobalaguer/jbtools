
function scan = scan_mvpa_rsa_regress(scan)
    %% scan = SCAN_MVPA_RSA_REGRESS(scan)
    % regress models against main RDM (RSA)
    % see also scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.model), 'scan_mvpa_rsa_regress: error. number of subjects doesnt match');
    
    % concatenate models
    u_model = {};
    for i_subject = 1:scan.subject.n
        [u_session,n_session] = numbers(scan.mvpa.variable.regressor{i_subject}{1}.session);
        u_model{i_subject} = {};
        for i_session = 1:n_session
            u_model{i_subject}{i_session} = [];
            for i_model = 1:length(scan.mvpa.variable.model{i_subject})
                ii_session = (scan.mvpa.variable.model{i_subject}{i_model}.session == u_session(i_session));
                model = scan.mvpa.variable.model{i_subject}{i_model}.matrix;
                assert(size(model,1) == length(ii_session), 'scan_mvpa_rsa_regress: error. oops.');
                assert(size(model,2) == length(ii_session), 'scan_mvpa_rsa_regress: error. oops.');
                model = model(ii_session,ii_session);
                u_model{i_subject}{i_session}(:,i_model) = mat2vec(model);
            end
        end
    end
    
    
    % regress
    u_rdm = scan.mvpa.variable.rdm;
    scan.mvpa.result.rsa = {};
    for i_subject = 1:scan.subject.n
        [u_session,n_session] = numbers(scan.mvpa.variable.regressor{i_subject}{1}.session);
        scan.mvpa.result.rsa{i_subject} = {};
        for i_session = 1:n_session
            ii_session = (scan.mvpa.variable.model{i_subject}{i_model}.session == u_session(i_session));
            
            x = u_model{i_subject}{i_session};
            y = mat2vec(u_rdm{i_subject}(ii_session,ii_session));
            [~,~,stats] = glmfit(x,y);

            result.stats = stats;
            scan.mvpa.result.rsa{i_subject}{i_session} = result;
        end
    end    
    
end