
function scan = scan_mvpa_summarize(scan)
    %% SCAN_MVPA_SUMMARIZE()
    % display a summary of the results of the multi-voxel pattern analysis
    % see also scan_mvpa

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*NASGU,*ASGLU>
    
    %% FUNCTION
    accuracy = [];
    d_prime  = [];
    global_accuracy = [];
    global_d_prime  = [];
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
        global_hit       = [];
        global_false_alarm = [];
        for i_level = 1:n_level
            level = u_level(i_level);
            hit_rate(i_level)           = mean(prediction(category==level)==level);
            false_alarm_rate(i_level)   = mean(prediction(category~=level)==level);
            global_hit         = [global_hit,         (prediction(category==level)==level)];
            global_false_alarm = [global_false_alarm, (prediction(category~=level)==level)];
        end
        global_hit_rate         = mean(global_hit);
        global_false_alarm_rate = mean(global_false_alarm);
        
        accuracy(i_subject,:) = (hit_rate) ./ (hit_rate + false_alarm_rate);
        d_prime( i_subject,:) = norminv(hit_rate) - norminv(false_alarm_rate);
        global_accuracy(i_subject) = (global_hit_rate) ./ (global_hit_rate + global_false_alarm_rate);
        global_d_prime( i_subject) = norminv(global_hit_rate) - norminv(global_false_alarm_rate);

    end
    
    
    % print global result
    m_prime     = mean(global_d_prime);
    s_prime     = ste( global_d_prime);
    m_accuracy  = mean(global_accuracy);
    s_accuracy  = ste( global_accuracy);
    [h,p,ci,stats]   = ttest(mat2vec(global_d_prime),0,'tail','right');
    if isnan(h), h = 0; end
    if h,   cprintf('*g','GLOBAL significant');
    else    cprintf('*r','GLOBAL not significant');
    end
    fprintf('\n');
    cprintf('*black','d-prime        = %+0.2f ± %0.2f ',m_prime,s_prime);       fprintf('\n');
    cprintf('*black','accuracy       = %+0.2f ± %0.2f ',m_accuracy,s_accuracy); fprintf('\n');
    cprintf('*black','p-value        = %0.3f          ',p);                     fprintf('\n');
    cprintf('*black','t-statistic    = %+0.2f         ',stats.tstat);           fprintf('\n');
    
    
    % print level results
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
