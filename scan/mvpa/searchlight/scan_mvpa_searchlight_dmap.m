
function scan = scan_mvpa_searchlight_dmap(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT_DMAP(scan)
    % create results map
    % see also scan_mvpa_dx_searchlight
    % see also scan_mvpa_rsa_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    scan.mvpa.variable.result.dmap = {};
    for i_subject = 1:scan.subject.n
        scan.mvpa.variable.result.dmap{i_subject} = {};
        for i_regressor = 1:length(scan.mvpa.regressor.name)
            dmap = reshape(scan.mvpa.variable.mask{i_subject},scan.mvpa.variable.size{i_subject});
            dmap = double(dmap);
            ii_dmap = logical(dmap(:));
            dmap(~ii_dmap) = nan;
            dmap( ii_dmap) = scan.mvpa.variable.result.searchlight{i_subject}{i_regressor};
            scan.mvpa.variable.result.dmap{i_subject}{i_regressor} = dmap;
        end
    end
    
end
