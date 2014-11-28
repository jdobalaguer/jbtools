
function scan = scan_rsa_regress(scan)
    %% scan = SCAN_RSA_REGRESS(scan)
    % regress models against main RDM (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.model), 'scan_rsa_regress: error. number of subjects doesnt match');
    
    % index sessions
    index_sessions = {};
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        ii_subject = (scan.rsa.regressor.subject == subject);
        [u_session,n_session] = numbers(scan.rsa.regressor.session(ii_subject));
        index_sessions{i_subject} = {};
        for i_session = 1:n_session
            session = u_session(i_session);
            ii_subject = (scan.rsa.regressor.subject == subject);
            ii_session = (scan.rsa.regressor.session(ii_subject) == session);
            ii_discard = scan.rsa.variable.discard{i_subject};
            ii_session(ii_discard) = [];
            index_sessions{i_subject}{i_session} = ii_session;
        end
    end
    
    % concatenate models
    u_model = {};
    for i_subject = 1:scan.subject.n
        ii_subject = (scan.rsa.regressor.subject == subject);
        [~,n_session] = numbers(scan.rsa.regressor.session(ii_subject));
        u_model{i_subject} = {};
        for i_session = 1:n_session
            u_model{i_subject}{i_session} = [];
            for i_model = 1:length(scan.rsa.variable.model{i_subject})
                ii_session = index_sessions{i_subject}{i_session};
                model = scan.rsa.variable.model{i_subject}{i_model}.matrix;
                assert(size(model,1) == length(ii_session), 'scan_rsa_regress: error. oops.');
                assert(size(model,2) == length(ii_session), 'scan_rsa_regress: error. oops.');
                model = model(ii_session,ii_session);
                u_model{i_subject}{i_session}(:,i_model) = mat2vec(model);
            end
        end
    end
    
    
    % regress
    u_rdm = scan.rsa.variable.rdm;
    scan.rsa.result = {};
    for i_subject = 1:scan.subject.n
        ii_subject = (scan.rsa.regressor.subject == subject);
        [~,n_session] = numbers(scan.rsa.regressor.session(ii_subject));
        scan.rsa.result{i_subject} = {};
        for i_session = 1:n_session
            ii_session = index_sessions{i_subject}{i_session};
            
            x = u_model{i_subject}{i_session};
            y = mat2vec(u_rdm{i_subject}(ii_session,ii_session));
            [~,~,stats] = glmfit(x,y);

            result.stats = stats;
            scan.rsa.result{i_subject}{i_session} = result;
        end
    end    
    
end