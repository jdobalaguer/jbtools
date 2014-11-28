
function scan = scan_rsa_pooling(scan)
    %% scan = SCAN_RSA_POOLING(scan)
    % merge all scanning sessions (RSA)
    % dont do it if there's variance in patterns between sessions
    % (unless you use )
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.rsa.pooling, return; end
    scan.rsa.regressor.session(:) = 1;

end