
function scan = scan_mvpa_index(scan)
    %% SCAN_MVPA_INDEX()
    % set selector for the cross-validation for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    for i_subject = 1:scan.subject.n
        % selector
        scan.mvpa.subject(i_subject) = create_xvalid_indices(scan.mvpa.subject(i_subject),scan.mvpa.variable.selector);
    end
    
    % update variable
    scan.mvpa.variable.selector = [scan.mvpa.variable.selector,'_xval'];

end
