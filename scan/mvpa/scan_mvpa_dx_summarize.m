
function scan = scan_mvpa_dx_summarize(scan)
    %% SCAN_MVPA_DX_SUMMARIZE()
    % display a summary of the results of the multi-voxel pattern analysis
    % see also scan_mvpa_dx

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*NASGU,*ASGLU>
    
    %% FUNCTION
    if scan.subject.n<2, return; end
    
    for i_regressor = 1:length(scan.mvpa.regressor.name)

        accuracy = [];
        d_prime  = [];
        global_accuracy = [];
        global_d_prime  = [];
        for i_subject = 1:scan.subject.n

            % concatenate iterations
            prediction  = [];
            target      = [];
            for i_crossvalid = 1:length(scan.mvpa.variable.result.dx{i_subject})
                prediction = [prediction; scan.mvpa.variable.result.dx{i_subject}{i_regressor}{i_crossvalid}.prediction ];
                target     = [target;     scan.mvpa.variable.result.dx{i_subject}{i_regressor}{i_crossvalid}.target];
            end

            % estimate d-prime
            [u_level,n_level] = numbers(target);
            hit_rate         = [];
            false_alarm_rate = [];
            global_hit       = [];
            global_false_alarm = [];
            for i_level = 1:n_level
                level = u_level(i_level);
                hit_rate(i_level)           = mean(prediction(target==level)==level);
                false_alarm_rate(i_level)   = mean(prediction(target~=level)==level);
                global_hit         = [global_hit;         (prediction(target==level)==level)];
                global_false_alarm = [global_false_alarm; (prediction(target~=level)==level)];
            end
            global_hit_rate         = mean(global_hit);
            global_false_alarm_rate = mean(global_false_alarm);

            accuracy(i_subject,:) = (hit_rate) ./ (hit_rate + false_alarm_rate);
            d_prime( i_subject,:) = norminv(hit_rate) - norminv(false_alarm_rate);
            global_accuracy(i_subject) = (global_hit_rate) ./ (global_hit_rate + global_false_alarm_rate);
            global_d_prime( i_subject) = norminv(global_hit_rate) - norminv(global_false_alarm_rate);

        end


        % print global result
        m_prime     = nanmean(nanmean(d_prime,2));
        s_prime     = nanste( nanmean(d_prime,2));
        m_accuracy  = nanmean(nanmean(accuracy,2));
        s_accuracy  = nanste( nanmean(accuracy,2));
        [h,p,ci,stats]   = ttest(nanmean(d_prime,2),0,'tail','right');
        if isnan(h), h = 0; end
        if h,   cprintf('*g','GLOBAL "%s" significant',scan.mvpa.regressor.name{i_regressor});
        else    cprintf('*r','GLOBAL "%s" not significant',scan.mvpa.regressor.name{i_regressor});
        end
        fprintf('\n');
        cprintf('*black','d-prime        = %+0.2f ± %0.2f ',m_prime,s_prime);       fprintf('\n');
        cprintf('*black','accuracy       = %+0.2f ± %0.2f ',m_accuracy,s_accuracy); fprintf('\n');
        cprintf('*black','p-value        = %0.3f          ',p);                     fprintf('\n');
        cprintf('*black','t-statistic    = %+0.2f         ',stats.tstat);           fprintf('\n');


        % print level results
        for i_level = 1:n_level
            level   = u_level(i_level);

            m_prime     = nanmean(d_prime(:,i_level));
            s_prime     = nanste( d_prime(:,i_level));
            m_accuracy  = nanmean(accuracy(:,i_level));
            s_accuracy  = nanste( accuracy(:,i_level));

            [h,p,ci,stats]   = ttest(d_prime(:,i_level),0,'tail','right');
            if isnan(h), h = 0; end
            if h,   cprintf([0,1,0],'LEVEL "%s[%d]" significant',scan.mvpa.regressor.name{i_regressor},u_level(i_level));
            else    cprintf([1,0,0],'LEVEL "%s[%d]" not significant',scan.mvpa.regressor.name{i_regressor},u_level(i_level));
            end
            fprintf('\n');
            fprintf('d-prime        = %+0.2f ± %0.2f \n',m_prime,s_prime);
            fprintf('accuracy       = %+0.2f ± %0.2f \n',m_accuracy,s_accuracy);
            fprintf('p-value        = %0.3f          \n',p);
            fprintf('t-statistic    = %+0.2f         \n',stats.tstat);
        end
    end
end
