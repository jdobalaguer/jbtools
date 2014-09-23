
function scan = scan_mvpa_variable(scan,mode)
    %% scan = SCAN_MVPA_VARIABLE(scan)
    % set temporal variables for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    scan.mvpa.variable              = struct();
    
    scan.mvpa.variable.mode         = mode;        ... mode
        
    scan.mvpa.variable.mask         = 'masc';      ... mask
    scan.mvpa.variable.pattern      = 'patt';      ... pattern
    scan.mvpa.variable.regressor    = 'regr';      ... regressor
    scan.mvpa.variable.selector     = 'sess';      ... selector

end