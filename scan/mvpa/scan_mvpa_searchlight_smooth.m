
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
            dmap_crispy = sprintf('%sdmap_crispy_%s_subject_%d.img', scan.dire.mvpa.map,scan.mvpa.regressor.name{i_regressor},scan.subject.u(i_subject));
            dmap_smooth = sprintf('%sdmap_smooth_%s_subject_%d.img', scan.dire.mvpa.map,scan.mvpa.regressor.name{i_regressor},scan.subject.u(i_subject));
            spm_smooth(dmap_crispy,dmap_smooth,8);
        end
    end
    
end
