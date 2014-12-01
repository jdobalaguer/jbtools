
function scan = scan_mvpa_dx_list(scan)
    %% scan = SCAN_MVPA_DX_LIST(scan)
    % set all possible combinations of sessions for crossvalidation
    % see also scan_mvpa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % create spheres
    scan.mvpa.variable.crossval = {};
    for i_subject = 1:scan.subject.n
        
        % subject
        subject = scan.subject.u(i_subject);
        x_session = scan.mvpa.variable.regressor{i_subject}{1}.session;
        fprintf('scan_mvpa: list cross-validation %02i: \n',subject);
        
        % numbers
        [u_session,n_session] = numbers(x_session);
        
        % create list
        crossval = struct('training',{},'evaluate',{});
        if n_session == 1
            crossval(1).training = ones(1,length(x_session));
            crossval(1).evaluate = ones(1,length(x_session));
        else
            for i_session = 1:n_session
                crossval(i_session).training = (x_session ~= u_session(i_session));
                crossval(i_session).evaluate = (x_session == u_session(i_session));
            end
        end
        
        % save
        scan.mvpa.variable.crossval{i_subject} = crossval;
    end
    
end
