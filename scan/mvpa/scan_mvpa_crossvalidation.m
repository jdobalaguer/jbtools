
function scan = scan_mvpa_crossvalidation(scan)
    %% SCAN_MVPA_CROSSVALIDATION()
    % runs the cross-validation for the multi-voxel pattern analysis
    % see also scan3_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    
    % run
    scan.mvpa.result = struct('header',{},'iterations',{},'total_perf',{});
    for i_subject = 1:scan.subject.n
        
        % indices
        scan.mvpa.subject(i_subject) = create_xvalid_indices(scan.mvpa.subject(i_subject),'sessions');                                  
        
        % anova
        scan.mvpa.subject(i_subject) = feature_select(scan.mvpa.subject(i_subject),scan.mvpa.image,'conds','sessions_xval');

        % classification
        if logical(scan.mvpa.zscore), [scan.mvpa.subject(i_subject), scan.mvpa.result(i_subject)] = cross_validation(scan.mvpa.subject(i_subject),[scan.mvpa.image,'_z'],'conds','sessions_xval',[scan.mvpa.image,'_thresh0.05'],scan.mvpa.classifier);
        else                          [scan.mvpa.subject(i_subject), scan.mvpa.result(i_subject)] = cross_validation(scan.mvpa.subject(i_subject),[scan.mvpa.image     ],'conds','sessions_xval',[scan.mvpa.image,'_thresh0.05'],scan.mvpa.classifier);
        end
    end

end
