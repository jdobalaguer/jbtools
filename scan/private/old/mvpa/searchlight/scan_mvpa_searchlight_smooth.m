
function scan = scan_mvpa_searchlight_smooth(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT_SMOOTH(scan)
    % smooth maps
    % see also scan_mvpa_dx_searchlight
    % see also scan_mvpa_rsa_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    for i_regressor = 1:length(scan.mvpa.regressor.name)
        for i_subject = 1:scan.subject.n
            dmap_crispy = sprintf('%ssub_%02i/final/dmap_crispy_%s.img', scan.dire.mvpa.map,scan.subject.u(i_subject),scan.mvpa.regressor.name{i_regressor});
            dmap_smooth = sprintf('%ssub_%02i/final/dmap_smooth_%s.img', scan.dire.mvpa.map,scan.subject.u(i_subject),scan.mvpa.regressor.name{i_regressor});
            spm_smooth(dmap_crispy,dmap_smooth,8);
        end
    end
    
end
