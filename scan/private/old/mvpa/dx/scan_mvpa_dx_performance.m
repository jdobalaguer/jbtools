
function scan = scan_mvpa_dx_performance(scan)
    %% SCAN_MVPA_DX_PERFORMANCE()
    % calculate performance of the decoding of the multi-voxel pattern analysis
    % see also scan_mvpa_dx

    %%  WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % numbers
    global_u_level = {};
    global_n_level = {};
    for i_regressor = 1:length(scan.mvpa.regressor.name)
        global_u_level{i_regressor} = unique(scan.mvpa.regressor.level{i_regressor}(~scan.mvpa.regressor.discard));
        global_n_level{i_regressor} = length(global_u_level);
    end
    
    % initialize results
    for i_subject = 1:scan.subject.n
        scan.mvpa.variable.result.dx{i_subject}.performance = {};
    end
    
    % calculate performance of MVPA
    for i_subject = 1:scan.subject.n
        
        % initialize variables
        hit_rate    = nan(1,global_n_level{i_regressor});
        false_alarm = nan(1,global_n_level{i_regressor});
        accuracy    = nan(1,global_n_level{i_regressor});
        d_prime     = nan(1,global_n_level{i_regressor});

        % regressor loop
        for i_regressor = 1:length(scan.mvpa.regressor.name)
            
            % concatenate iterations
            prediction  = [];
            target      = [];
            for i_crossvalid = 1:length(scan.mvpa.variable.result.dx{i_subject})
                prediction = [prediction; scan.mvpa.variable.result.dx{i_subject}.crossval{i_regressor}{i_crossvalid}.evaluate_prediction ];
                target     = [target;     scan.mvpa.variable.result.dx{i_subject}.crossval{i_regressor}{i_crossvalid}.evaluate_target];
            end

            % estimate d-prime
            [u_level,n_level] = numbers(target);
            hr  = [];
            far = [];
            for i_level = 1:n_level
                level = u_level(i_level);
                hr(i_level)  = mean(prediction(target==level)==level);
                far(i_level) = mean(prediction(target~=level)==level);
            end
            
            ii_level = ismember(global_u_level{i_regressor},u_level);
            hit_rate(   ii_level) = hr;
            false_alarm(ii_level) = far;
            accuracy(   ii_level) = (hr) ./ (hr + far);
            d_prime(    ii_level) = norminv(0.01 + 0.98*hr) - norminv(0.01 + 0.98*far);
            
            % save
            scan.mvpa.variable.result.dx{i_subject}.performance{i_regressor} = struct();
            scan.mvpa.variable.result.dx{i_subject}.performance{i_regressor}.hit_rate           = hit_rate;
            scan.mvpa.variable.result.dx{i_subject}.performance{i_regressor}.false_alarm_rate   = false_alarm;
            scan.mvpa.variable.result.dx{i_subject}.performance{i_regressor}.accuracy           = accuracy;
            scan.mvpa.variable.result.dx{i_subject}.performance{i_regressor}.d_prime            = d_prime;
        
        end
    end
end
