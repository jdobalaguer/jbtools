
function scan = scan_mvpa_dx_crossval(scan)
    %% scan = SCAN_MVPA_DX_LIST(scan)
    % set all possible combinations of sessions for crossvalidation
    % see also scan_mvpa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % create spheres
    scan.mvpa.variable.result.dx = {};
    for i_subject = 1:scan.subject.n
        
        % subject
        subject = scan.subject.u(i_subject);
        
        % numbers
        u_crossval = scan.mvpa.variable.crossval{i_subject};
        n_crossval = length(u_crossval);
        n_regressor = length(scan.mvpa.variable.regressor{i_subject});
        
        % do cross-validation
        scan.mvpa.variable.result.dx{i_subject} = {};
        
        for i_regressor = 1:n_regressor
            scan.mvpa.variable.result.dx{i_subject}{i_regressor} = {};
            for i_crossval = 1:n_crossval
                fprintf('scan_mvpa: do cross-validation %02i: list %d : \n',subject,i_crossval);
                ii_training = u_crossval(i_crossval).training;
                ii_evaluate = u_crossval(i_crossval).evaluate;

                % training
                x = scan.mvpa.variable.beta{i_subject}(:,ii_training)';
                y = scan.mvpa.variable.regressor{i_subject}{i_regressor}.level(ii_training)';
                f = scan.mvpa.decoder.training.function;
                p = scan.mvpa.decoder.training.parameters;
                b = f(x,y,p{:});

                % evaluate
                x = scan.mvpa.variable.beta{i_subject}(:,ii_evaluate)';
                y = scan.mvpa.variable.regressor{i_subject}{i_regressor}.level(ii_evaluate)';
                f = scan.mvpa.decoder.evaluate.function;
                p = scan.mvpa.decoder.evaluate.parameters;
                yfit = f(b,x,p{:});
%                 yfit = round(yfit);

                % save
                result = struct();
                result.prediction = yfit;
                result.target     = y;
                result.error      = y - yfit;
                scan.mvpa.variable.result.dx{i_subject}{i_regressor}{i_crossval} = result;
            end
        end
    end
    
end
