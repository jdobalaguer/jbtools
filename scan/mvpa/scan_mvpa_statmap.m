
function scan = scan_mvpa_statmap(scan)
    %% scan = SCAN_MVPA_STATMAP(scan)
    % set statmap masks for the cross-validation for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED,*ERTAG>
    
    %% FUNCTION
    
    switch(scan.mvpa.variable.mode)
        case 'run'
            
            % anova statmaps
            for i_subject = 1:scan.subject.n
                scan.mvpa.subject(i_subject) = feature_select(scan.mvpa.subject(i_subject),scan.mvpa.variable.pattern,scan.mvpa.variable.regressor,scan.mvpa.variable.selector);
            end
            % update variable
            scan.mvpa.variable.mask    = [scan.mvpa.variable.pattern,'_thresh0.05'];
            
        case 'searchlight'

            % searchlight statmaps
            for i_subject = 1:scan.subject.n
                statmap_srch_arg.adj_list               = scan.mvpa.subject(i_subject).adj_sphere;
                statmap_srch_arg.obj_funct              = 'statmap_classify';
                statmap_srch_arg.scratch.class_args     = scan.mvpa.classifier;
                statmap_srch_arg.scratch.perfmet_funct  = 'perfmet_maxclass';
                statmap_srch_arg.scratch.perfmet_args   = struct([]);
                scan.mvpa.subject(i_subject) = feature_select(scan.mvpa.subject(i_subject),scan.mvpa.variable.pattern,scan.mvpa.variable.regressor,scan.mvpa.variable.selector,'statmap_funct','statmap_searchlight','statmap_arg',statmap_srch_arg,'new_map_patname',[scan.mvpa.variable.pattern,'_srch'],'thresh',[]);
            end

        otherwise
            save('error.mat','scan')
            error('scan_mvpa_crossvalidation: error. unknown mode "%s"',scan.mvpa.variable.mode);
    end
end
