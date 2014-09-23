
function scan = scan_mvpa_sl_selector(scan)
    %% SCAN_MVPA_SL_SELECTOR()
    % create a new selector for searchlight generalization
    % see also scan_mvpa_searchlight

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    for i_subject = 1:scan.subject.n
        
        %  create group of cross-validation selectors
        session     = get_mat(scan.mvpa.subject(i_subject),'selector',scan.mvpa.variable.selector);
        n_session   = length(unique(session));
        n_time      = length(session);
        session_sl  = ones(n_session,n_time);
        
        assert(n_session>=3 , 'scan_mvpa_sl_selector: error. you need at least 4 sessions');
        
        % label one session with 2s for evaluation
        for i_session = 1:n_session, session_sl(i_session, session==i_session) = 2; end

        %  label one session with 3s for searchlight-generalization
%         for i_session=1:n_session, session_sl(i_session, session==n_session-i_session+1) = 3; end
        for i_session=1:n_session, session_sl(i_session, session==mod1(i_session+1,n_session)) = 3; end
        
        % add each row as a selector, and group together
        for i_session = 1:n_session, scan.mvpa.subject(i_subject) = initset_object(scan.mvpa.subject(i_subject),'selector',sprintf('%s_xval_sl_%i',scan.mvpa.variable.selector,i_session),session_sl(i_session,:),'group_name',[scan.mvpa.variable.selector,'_xval_sl']); end
    end
    
    % update variable
    scan.mvpa.variable.selector = [scan.mvpa.variable.selector,'_xval_sl'];
end
