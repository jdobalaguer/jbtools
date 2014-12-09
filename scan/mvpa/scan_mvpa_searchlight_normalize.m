
function scan = scan_mvpa_searchlight_normalize(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT_NORMALIZE(scan)
    % normalize searchligh dmaps
    % see also scan_mvpa_dx_searchlight
    % see also scan_mvpa_rsa_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % save d-maps into files
    template = [scan.dire.mvpa.template,scan.mvpa.template];
    mkdirp(scan.dire.mvpa.map);
    for i_regressor = 1:length(scan.mvpa.regressor.name)
        for i_subject = 1:scan.subject.n
            d_map = scan.mvpa.variable.result.dmap{i_subject}{i_regressor};
            scan_nifti_save(sprintf('%sdmap_crispy_%s_subject_%d.img',scan.dire.mvpa.map,scan.mvpa.regressor.name{i_regressor},scan.subject.u(i_subject)),d_map,template);
        end
    end
        
    % return if already normalization
    if ~scan.mvpa.mni, return; end
    
    % transform to MNI space
    error('scan_mvpa_searchlight_normalize: error. TODO');
    
end
