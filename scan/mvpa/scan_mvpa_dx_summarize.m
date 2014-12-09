
function scan = scan_mvpa_dx_summarize(scan)
    %% SCAN_MVPA_DX_SUMMARIZE()
    % display a summary of the results of the multi-voxel pattern analysis
    % see also scan_mvpa_dx

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*NASGU,*ASGLU>
    
    %% FUNCTION
    
    % return
    if ~scan.mvpa.summarize, return; end
    
    % numbers
    global_u_level = {};
    global_n_level = {};
    for i_regressor = 1:length(scan.mvpa.regressor.name)
        global_u_level{i_regressor} = unique(scan.mvpa.regressor.level{i_regressor}(~scan.mvpa.regressor.discard));
        global_n_level{i_regressor} = length(global_u_level{i_regressor});
    end
    
    % print statistical summary
    for i_regressor = 1:length(scan.mvpa.regressor.name)
        
        % construct matrix
        accuracy = [];
        d_prime  = [];
        for i_subject = 1:scan.subject.n
            accuracy(i_subject,:) = scan.mvpa.variable.result.dx{i_subject}.performance{i_regressor}.accuracy;
            d_prime( i_subject,:) = scan.mvpa.variable.result.dx{i_subject}.performance{i_regressor}.d_prime;
        end
        
        % global
        m_prime     = nanmean(nanmean(d_prime,2));
        s_prime     = nanste( nanmean(d_prime,2));
        m_accuracy  = nanmean(nanmean(accuracy,2));
        s_accuracy  = nanste( nanmean(accuracy,2));
        [h,p,ci,stats]   = ttest(nanmean(d_prime,2),0,'tail','right');
        if isnan(h), h = 0; end
        fprintf('\n');
        if h,   cprintf('*g','GLOBAL "%s" significant',scan.mvpa.regressor.name{i_regressor});
        else    cprintf('*r','GLOBAL "%s" not significant',scan.mvpa.regressor.name{i_regressor});
        end
        fprintf('\n');
        cprintf('*black','d-prime        = %+0.2f ± %0.2f ',m_prime,s_prime);       fprintf('\n');
        cprintf('*black','accuracy       = %+0.2f ± %0.2f ',m_accuracy,s_accuracy); fprintf('\n');
        cprintf('*black','p-value        = %0.3f          ',p);                     fprintf('\n');
        cprintf('*black','t-statistic    = %+0.2f         ',stats.tstat);           fprintf('\n');


        % by level
        for i_level = 1:global_n_level{i_regressor}
            level   = global_u_level{i_regressor}(i_level);

            m_prime     = nanmean(d_prime(:,i_level));
            s_prime     = nanste( d_prime(:,i_level));
            m_accuracy  = nanmean(accuracy(:,i_level));
            s_accuracy  = nanste( accuracy(:,i_level));

            [h,p,ci,stats]   = ttest(d_prime(:,i_level),0,'tail','right');
            if isnan(h), h = 0; end
            if h,   cprintf([0,1,0],'LEVEL "%s[%d]" significant',scan.mvpa.regressor.name{i_regressor},global_u_level{i_regressor}(i_level));
            else    cprintf([1,0,0],'LEVEL "%s[%d]" not significant',scan.mvpa.regressor.name{i_regressor},global_u_level{i_regressor}(i_level));
            end
            fprintf('\n');
            fprintf('d-prime        = %+0.2f ± %0.2f \n',m_prime,s_prime);
            fprintf('accuracy       = %+0.2f ± %0.2f \n',m_accuracy,s_accuracy);
            fprintf('p-value        = %0.3f          \n',p);
            fprintf('t-statistic    = %+0.2f         \n',stats.tstat);
        end
    end
end
