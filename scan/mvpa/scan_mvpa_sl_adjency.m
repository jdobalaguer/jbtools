
function scan = scan_mvpa_sl_adjency(scan)
    %% SCAN_MVPA_SL_ADJENCY()
    % create adjency matrix for searchlight on MVPA
    % see also scan_mvpa_searchlight

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    for i_subject = 1:scan.subject.n
        % create adjacency matrix
        scan.mvpa.variable.mask
        scan.mvpa.subject(i_subject).adj_sphere = create_adj_list(scan.mvpa.subject(i_subject),scan.mvpa.variable.mask,'radius',scan.mvpa.sphere);
    end

end
