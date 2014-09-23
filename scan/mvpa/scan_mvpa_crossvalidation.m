
function scan = scan_mvpa_crossvalidation(scan)
    %% SCAN_MVPA_CROSSVALIDATION()
    % runs the cross-validation for the multi-voxel pattern analysis
    % see also scan_mvpa_run
    %          scan_mvpa_searchlight

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    
    % classification
    scan.mvpa.result = struct('header',{},'iterations',{},'total_perf',{});
    for i_subject = 1:scan.subject.n
        [scan.mvpa.subject(i_subject), scan.mvpa.result(i_subject)] = cross_validation( scan.mvpa.subject(i_subject),   ... subject
                                                                                        scan.mvpa.variable.pattern,     ... pattern
                                                                                        scan.mvpa.variable.regressor,   ... regressor
                                                                                        scan.mvpa.variable.selector,    ... selector
                                                                                        scan.mvpa.variable.mask,        ... mask
                                                                                        scan.mvpa.classifier);          ... classifier
    end

end
