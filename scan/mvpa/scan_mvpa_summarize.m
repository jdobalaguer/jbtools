
function scan = scan_mvpa_summarize(scan)
    %% SCAN_MVPA_SUMMARIZE()
    % display a summary of the results of the multi-voxel pattern analysis
    % see also scan_mvpa

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*NASGU,*ASGLU>
    
    %% FUNCTION
    d_prime  = [];
    for i_subject = 1:scan.subject.n
        
        % concatenate iterations
        prediction  = [];
        category    = [];
        for i_iteration = 1:length(scan.mvpa.result(i_subject).iterations)
            prediction = [prediction, scan.mvpa.result(i_subject).iterations(i_iteration).perfmet.guesses ];
            category   = [category,   scan.mvpa.result(i_subject).iterations(i_iteration).perfmet.desireds];
        end
        
        % estimate d-prime
        [u_level,n_level] = numbers(category);
        hit_rate         = [];
        false_alarm_rate = [];
        for i_level = 1:n_level
            level = u_level(i_level);
            hit_rate(i_level)           = mean(prediction(category==level)==level);
            false_alarm_rate(i_level)   = mean(prediction(category~=level)==level);
        end
        accuracy(i_subject,:) = (hit_rate) ./ (hit_rate + false_alarm_rate);
        d_prime( i_subject,:) = norminv(hit_rate) - norminv(false_alarm_rate);

    end
    
    
    % print result
    for i_level = 1:n_level
        level   = u_level(i_level);
        
        m_prime     = mean(d_prime(:,i_level));
        s_prime     = ste( d_prime(:,i_level));
        m_accuracy  = mean(accuracy(:,i_level));
        s_accuracy  = ste( accuracy(:,i_level));
        
        [h,p,ci,stats]   = ttest(d_prime(:,i_level),0,'tail','right');
        if isnan(h), h = 0; end
        if h,   cprintf([0,1,0],'LEVEL "%s" significant',scan.mvpa.regressor.name{i_level});
        else    cprintf([1,0,0],'LEVEL "%s" not significant',scan.mvpa.regressor.name{i_level});
        end
        fprintf('\n');
        fprintf('d-prime        = %+0.2f ± %0.2f \n',m_prime,s_prime);
        fprintf('accuracy       = %+0.2f ± %0.2f \n',m_accuracy,s_accuracy);
        fprintf('p-value        = %0.3f          \n',p);
        fprintf('t-statistic    = %+0.2f         \n',stats.tstat);
    end
    
end
