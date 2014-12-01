
function scan = scan_mvpa_regressor(scan)
    %% scan = SCAN_MVPA_REGRESSOR(scan)
    % set regressors
    % see also scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    scan.mvpa.variable.regressor = {};
    
    % set regressors
    for i_subject = 1:scan.subject.n
        scan.mvpa.variable.regressor{i_subject} = {};
        
        subject = scan.subject.u(i_subject);
        ii_subject = (scan.mvpa.regressor.subject == subject);
        if isempty(scan.mvpa.regressor.discard), scan.mvpa.regressor.discard = false(size(ii_subject)); end
        ii_discard = scan.mvpa.regressor.discard;
        ii = ii_subject & ~ii_discard;
        
        % set regressor per subject
        for i_regressor = 1:length(scan.mvpa.regressor.name)
            
            regressor           = struct();
            regressor.index     = ii;
            regressor.discard   = ii_discard(ii_subject);
            regressor.session   = scan.mvpa.regressor.session(ii);
            regressor.name      = scan.mvpa.regressor.name{i_regressor};
            regressor.level     = scan.mvpa.regressor.level{i_regressor}(ii);
            
            % save
            scan.mvpa.variable.regressor{i_subject}{i_regressor} = regressor;
            
        end
    end
end