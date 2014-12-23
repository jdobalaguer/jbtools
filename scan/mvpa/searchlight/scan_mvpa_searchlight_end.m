
function scan = scan_mvpa_searchlight_end(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT_END(scan)
    % searchlight script
    % see also scan_mvpa_dx_searchlight
    % see also scan_mvpa_rsa_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % bring variables back
    scan.mvpa.variable.beta = scan.mvpa.variable.searchlight.beta;
    scan.mvpa.variable.mask = scan.mvpa.variable.searchlight.mask;

    % clean
    scan.mvpa.variable = rmfield(scan.mvpa.variable,'searchlight');
    
end
