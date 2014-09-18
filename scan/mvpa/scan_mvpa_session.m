
function scan = scan_mvpa_session(scan)
    %% SCAN_MVPA_SESSION()
    % set the runs for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% SESSION
    for i_subject = 1:scan.subject.n
        ii_subject = (scan.mvpa.regressor.subject == scan.subject.u(i_subject));
        ii_discard = scan.mvpa.regressor.discard;
        sessions = scan.mvpa.regressor.session(ii_subject & ~ii_discard);
        
        scan.mvpa.subject(i_subject) = init_object(      scan.mvpa.subject(i_subject) ,'selector', 'sessions'); % selector
        scan.mvpa.subject(i_subject) = set_mat(          scan.mvpa.subject(i_subject) ,'selector', 'sessions', sessions);
        if logical(scan.mvpa.zscore), scan.mvpa.subject(i_subject) = zscore_runs(scan.mvpa.subject(i_subject),scan.mvpa.image,'sessions'); end % normalization
    end

end
