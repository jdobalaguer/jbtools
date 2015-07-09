
function scan = scan_mvpa_rsa_setmodel(scan)
    %% scan = SCAN_MVPA_RSA_SETMODEL(scan)
    % Set models to regress against the main RDM (RSA)
    % see also scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    scan.mvpa.variable.model = cell(1,scan.subject.n);
    for i_subject = 1:scan.subject.n
        
        % numbers

        subject = scan.subject.u(i_subject);
        fprintf('scan_mvpa: set models %02i: \n',subject);
        
        % from regressors
        u_model = {};
        for i_regressor = 1:length(scan.mvpa.regressor.name)
            regressor = scan.mvpa.variable.regressor{i_subject}{i_regressor};
            
            % numbers
            [u_level,n_level] = numbers(regressor.level);
            n_beta = size(scan.mvpa.variable.rdm{i_subject},1);
            
            % create
            model.name      = regressor.name;
            model.session   = regressor.session;
            model.level     = regressor.level;
            model.size      = n_beta;
            model.matrix    = false(n_beta,n_beta);
            for i_level = 1:n_level
                ii_level = (regressor.level == u_level(i_level));
                m_level  = repmat(ii_level,n_beta,1); 
                model.matrix = model.matrix | (m_level' .* m_level);
            end
            model.matrix = ~model.matrix;
            u_model{end+1} = model;
        end
        
        % save
        scan.mvpa.variable.model{i_subject} = u_model;
    end
end