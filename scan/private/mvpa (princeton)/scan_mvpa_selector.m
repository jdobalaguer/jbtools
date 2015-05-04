
function scan = scan_mvpa_selector(scan)
    %% SCAN_MVPA_SELECTOR()
    % set the selector for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% SESSION
    for i_subject = 1:scan.subject.n
        ii_subject = (scan.mvpa.regressor.subject == scan.subject.u(i_subject));
        ii_discard = scan.mvpa.regressor.discard;
        sessions = scan.mvpa.regressor.session(ii_subject & ~ii_discard);
        
        scan.mvpa.subject(i_subject) = init_object(      scan.mvpa.subject(i_subject) ,'selector', scan.mvpa.variable.selector);
        scan.mvpa.subject(i_subject) = set_mat(          scan.mvpa.subject(i_subject) ,'selector', scan.mvpa.variable.selector, sessions);
    end

end
