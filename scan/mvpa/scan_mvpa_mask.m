
function scan = scan_mvpa_mask(scan)
    %% SCAN_MVPA_MASK()
    % load the mask for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    for i_subject = 1:scan.subject.n
        scan.mvpa.subject(i_subject) = load_spm_mask(scan.mvpa.subject(i_subject),scan.mvpa.mask,scan.file.mvpa_mask);
    end

end
