
function scan = scan_mvpa_pooling(scan)
    %% scan = SCAN_MVPA_POOLING(scan)
    % merge all scanning sessions
    % dont do it if there's variance in patterns between sessions
    % see also scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.mvpa.pooling, return; end
    
    % regressor
    scan.mvpa.regressor.session(:) = 1;
    
    % variable
    if isfield(scan.mvpa,'variable') && isfield(scan.mvpa.variable,'regressor')
        for i_subject = 1:scan.subject.n
            for i_regressor = 1:length(scan.mvpa.variable.regressor{i_subject})
                scan.mvpa.variable.regressor{i_subject}{i_regressor}.session(:) = 1;
            end
        end
    end

end