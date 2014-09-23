
function scan = scan_mvpa_zscore(scan)
    %% SCAN_MVPA_ZSCORE()
    % apply zscore (global normalisation) on the images for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    if ~scan.mvpa.zscore, return; end
    
    % normalization
    for i_subject = 1:scan.subject.n
        scan.mvpa.subject(i_subject) = zscore_runs(scan.mvpa.subject(i_subject),scan.mvpa.variable.pattern,scan.mvpa.variable.selector);
    end
    
    % update variable
    scan.mvpa.variable.pattern = [scan.mvpa.variable.pattern,'_z'];

end
