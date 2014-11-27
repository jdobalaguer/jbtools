
function scan = scan_rsa_setmodel(scan)
    %% scan = SCAN_RSA_SETMODEL(scan)
    % Set models to regress against the main RDM (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    scan.rsa.variable.model = cell(1,scan.subject.n);
    for i_subject = 1:scan.subject.n
        
        % numbers

        subject = scan.subject.u(i_subject);
        fprintf('scan_rsa: set models %02i: \n',subject);
        
        % from regressors
        u_model = {};
        for i_regressor = 1:length(scan.rsa.regressor.name)
            
            % discarded images
            ii_subject = (scan.rsa.regressor.subject == subject);
            if isempty(scan.rsa.regressor.discard),
                ii_discard = false(size(scan.rsa.regressor.subject));
            else
                ii_discard = (scan.rsa.regressor.discard);
            end
            ii_regressor = (ii_subject & ~ii_discard);

            % numbers
            [u_level,n_level] = numbers(scan.rsa.regressor.level{i_regressor}(ii_regressor));
            n_beta = size(scan.rsa.variable.rdm{i_subject},1);
            
            % assert
            assert(sum(ii_regressor)==n_beta, 'scan_rsa_setmodel: error. number of subjects doesnt match');
            
            % create
            model.name   = scan.rsa.regressor.name{i_regressor};
            model.size   = n_beta;
            model.matrix = false(n_beta,n_beta);
            for i_level = 1:n_level
                ii_level = (scan.rsa.regressor.level{i_regressor}(ii_regressor) == u_level(i_level));
                m_level  = repmat(ii_level,n_beta,1); 
                model.matrix = model.matrix | (m_level' .* m_level);
            end
            model.matrix = ~model.matrix;
            
            u_model{end+1} = model;
        end
        
        % from raw RDM model
        if isfield(scan.rsa,'model'),
            for i_model = 1:length(scan.rsa.model)
                u_model{end+1} = scan.rsa.model{i_model};
            end
        end
        
        % save
        scan.rsa.variable.model{i_subject} = u_model;
    end
end