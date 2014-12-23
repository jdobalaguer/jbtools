
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
        scan.mvpa.variable.result.dx{i_subject} = struct();
        scan.mvpa.variable.result.dx{i_subject}.crossval = {};
        
        for i_regressor = 1:n_regressor
            scan.mvpa.variable.result.dx{i_subject}.crossval{i_regressor} = {};
            for i_crossval = 1:n_crossval
                
                scan_mvpa_verbose(scan,sprintf('scan_mvpa: do cross-validation %02i: list %d :',subject,i_crossval));
                ii_training = logical(u_crossval(i_crossval).training);
                ii_evaluate = logical(u_crossval(i_crossval).evaluate);

                % training
                x_training = scan.mvpa.variable.beta{i_subject}(:,ii_training)';
                y_training = scan.mvpa.variable.regressor{i_subject}{i_regressor}.level(ii_training)';
                f_training = scan.mvpa.decoder.training.function;
                p_training = scan.mvpa.decoder.training.parameters;

                % evaluate
                x_evaluate = scan.mvpa.variable.beta{i_subject}(:,ii_evaluate)';
                y_evaluate = scan.mvpa.variable.regressor{i_subject}{i_regressor}.level(ii_evaluate)';
                f_evaluate = scan.mvpa.decoder.evaluate.function;
                p_evaluate = scan.mvpa.decoder.evaluate.parameters;
                
                if size(scan.mvpa.variable.beta{i_subject},1)
                    % if voxels available
                    b = f_training(x_training,y_training,p_training{:});
                    y_predict  = f_evaluate(b,x_evaluate,p_evaluate{:});
                else
                    % if cross-validation impossible
                    b = [];
                    y_predict = nan(size(y_evaluate));
                end
                
                % save
                result = struct();
                result.training_output     = b;
                result.evaluate_prediction = y_predict;
                result.evaluate_target     = y_evaluate;
                result.evaluate_error      = y_evaluate - y_predict;
                scan.mvpa.variable.result.dx{i_subject}.crossval{i_regressor}{i_crossval} = result;
            end
        end
    end
    
end
