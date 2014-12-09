
function scan = scan_mvpa_runmean(scan)
    %% scan = SCAN_MVPA_RUNMEAN(scan)
    % average across runs
    % see also scan_mvpa_dx
    %          scan_mvpa_rsa
    %          scan_mvpa_uni
    %          scan_mvpa_sdt
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.mvpa.runmean, return; end
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.beta), 'scan_mvpa_runmean: error. number of subjects doesnt match');
    assert(length(scan.mvpa.regressor.name)==1,               'scan_mvpa_runmean: error. use runmean only with one regressor');
    
    % remove nans
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('scan_mvpa: session mean %02i: \n',subject);
    
        % load 
        beta        = scan.mvpa.variable.beta{i_subject};
        regressor   = scan.mvpa.variable.regressor{i_subject}{1};
        
        % numbers
        [u_level,   n_level]    = numbers(regressor.level);
        [u_session, n_session]  = numbers(regressor.session);
        
        % average across runs & levels
        new_beta = [];
        new_reg = struct();
        new_reg.name    = regressor.name;
        new_reg.session = [];
        new_reg.level   = [];
        j_pattern = 0;
        for i_session = 1:n_session
            for i_level = 1:n_level
                j_pattern = j_pattern + 1;
                
                session = u_session(i_session);
                level   = u_level(  i_level);
                
                ii_session = (regressor.session == session);
                ii_level   = (regressor.level   == level);
                ii_pattern = (ii_session & ii_level);
                new_reg.session(j_pattern)  = session;
                new_reg.level(j_pattern)    = level;
                new_beta(:,j_pattern) = mean(beta(:,ii_pattern),2);
            end
        end
        
        % save
        scan.mvpa.variable.beta{i_subject}          = new_beta;
        scan.mvpa.variable.regressor{i_subject}{1}  = new_reg;
    end
end
