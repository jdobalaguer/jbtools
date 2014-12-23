
function scan = scan_mvpa_verbose(scan,message)
    %% scan = SCAN_MVPA_VERBOSE(scan)
    % print if verbose
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % return
    if ~scan.mvpa.verbose, return; end
    
    % print
    fprintf('%s \n',message);

end