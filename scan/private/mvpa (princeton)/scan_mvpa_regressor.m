
function scan = scan_mvpa_regressor(scan)
    %% SCAN_MVPA_REGRESSOR()
    % set the regressors for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW>
    
    %% FUNCTION
    for i_subject = 1:scan.subject.n
        
        % get values
        ii_subject = (scan.mvpa.regressor.subject == scan.subject.u(i_subject));
        ii_discard = scan.mvpa.regressor.discard;
        names_regs = scan.mvpa.regressor.name;
        value_regs = [];
        for i_level = 1:length(scan.mvpa.regressor.level)
            value_regs(i_level,:) = logical(scan.mvpa.regressor.level{i_level}(ii_subject & ~ii_discard));
        end
        
        % set values
        scan.mvpa.subject(i_subject) = init_object(  scan.mvpa.subject(i_subject),'regressors',scan.mvpa.variable.regressor);
        scan.mvpa.subject(i_subject) = set_mat(      scan.mvpa.subject(i_subject),'regressors',scan.mvpa.variable.regressor,value_regs);
        scan.mvpa.subject(i_subject) = set_objfield( scan.mvpa.subject(i_subject),'regressors',scan.mvpa.variable.regressor,'condnames',names_regs);
    end

end
