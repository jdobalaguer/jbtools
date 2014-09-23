
function scan = scan_mvpa_sl_sortedmask(scan)
    %% SCAN_MVPA_SL_SORTEDMASK()
    % sort masks fort searchlight MVPA
    % see also scan_mvpa_searchlight

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    
    for i_subject = 1:scan.subject.n
        % create masks from the statmaps
        scan.mvpa.subject(i_subject) = create_sorted_mask(scan.mvpa.subject(i_subject),scan.mvpa.variable.mask,[scan.mvpa.variable.pattern,'_srch_200'],200,'descending',true);
    end

    % update variable
    scan.mvpa.variable.mask = [scan.mvpa.variable.pattern,'_srch_200'];
    
end
