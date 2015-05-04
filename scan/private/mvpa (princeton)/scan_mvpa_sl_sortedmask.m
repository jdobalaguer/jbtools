
function scan = scan_mvpa_sl_sortedmask(scan)
    %% SCAN_MVPA_SL_SORTEDMASK()
    % sort masks fort searchlight MVPA
    % see also scan_mvpa_searchlight

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % check nvox
    min_nvox = Inf;
    for i_subject = 1:scan.subject.n
        min_nvox = min(min_nvox , get_objfield(scan.mvpa.subject,'Mask',scan.mvpa.variable.mask,'nvox'));
    end
    if scan.mvpa.nvoxel > min_nvox
        warning('scan_mvpa_sl_sortedmask: warning. nvoxel is bigger than the mask. set to %d voxels', min_nvox);
        scan.mvpa.nvoxel = min_nvox;
    end
    
    % update variable
    scan.mvpa.variable.mask = sprintf('%s_srch_%d',scan.mvpa.variable.pattern,scan.mvpa.nvoxel);
    
    % create masks from the statmaps
    for i_subject = 1:scan.subject.n
        scan.mvpa.subject(i_subject) = create_sorted_mask(scan.mvpa.subject(i_subject),[scan.mvpa.variable.pattern,'_srch'],scan.mvpa.variable.mask,scan.mvpa.nvoxel,'descending',true);
    end
    
end
