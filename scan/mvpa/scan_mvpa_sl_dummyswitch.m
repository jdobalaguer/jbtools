
function scan = scan_mvpa_sl_dummyswitch(scan)
    %% SCAN_MVPA_SL_DUMMYSWITCH()
    % switch to dummy selector for cross-validation
    % (this avoids some warnings)
    % see also scan_mvpa_searchlight

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % switch to dummy selector
    if scan.mvpa.dummy_sel
        scan.mvpa.variable.selector = [scan.mvpa.variable.selector,'_dummy'];
    end

end
