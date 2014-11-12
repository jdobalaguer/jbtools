
function scan = scan_mvpa_sl_sortedmask(scan)
    %% SCAN_MVPA_SL_SORTEDMASK()
    % sort masks fort searchlight MVPA
    % see also scan_mvpa_searchlight

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % update variable
    scan.mvpa.variable.mask = sprintf('%s_srch_%d',scan.mvpa.variable.pattern,scan.mvpa.nvoxel);
    
    % create masks from the statmaps
    for i_subject = 1:scan.subject.n
        scan.mvpa.subject(i_subject) = create_sorted_mask(scan.mvpa.subject(i_subject),[scan.mvpa.variable.pattern,'_srch'],scan.mvpa.variable.mask,scan.mvpa.nvoxel,'descending',true);
    end
    
end
