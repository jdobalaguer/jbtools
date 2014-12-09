
function scan = scan_mvpa_searchlight_save(scan,i_sphere)
    %% scan = SCAN_MVPA_SEARCHLIGHT_SAVE(scan)
    % save iteration for searchlight
    % see also scan_mvpa_dx_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % save d prime
    for i_subject = 1:scan.subject.n
        if scan.mvpa.variable.searchlight.n_sphere(i_subject) > i_sphere,
            for i_regressor = 1:length(scan.mvpa.regressor.name)
                scan.mvpa.variable.result.searchlight{i_subject}{i_regressor}(i_sphere) = nanmean(scan.mvpa.variable.result.dx{i_subject}.performance{i_regressor}.d_prime);
            end
        end
    end
end
