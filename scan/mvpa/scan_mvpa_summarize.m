
function scan = scan_mvpa_summarize(scan)
    %% SCAN_MVPA_SUMMARIZE()
    % display a summary of the results of the multi-voxel pattern analysis
    % see also scan_mvpa

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*NASGU>
    
    %% FUNCTION
    for i_subject = 1:scan.subject.n
        d_prime  = [];
        for i_iteration = 1:length(scan.mvpa.result(i_subject).iterations)
            [u_level,n_level] = numbers(scan.mvpa.result(i_subject).iterations(i_iteration).perfmet.desireds);
            for i_level = 1:n_level
                level = u_level(i_level);
                prediction          = scan.mvpa.result(i_subject).iterations(i_iteration).perfmet.guesses ;
                category            = scan.mvpa.result(i_subject).iterations(i_iteration).perfmet.desireds;
                hit_rate            = mean(prediction(category==level)==level);
                false_alarm_rate    = mean(prediction(category~=level)==level);
                d_prime(i_iteration,i_level) = norminv(hit_rate) - norminv(false_alarm_rate);
            end
        end
        for i_level = 1:n_level
            level   = u_level(i_level);
            m_prime = mean(d_prime(:,i_level));
            s_prime = std( d_prime(:,i_level));
            h       = ttest(d_prime(:,i_level),0,'tail','right');
            if isnan(h), h = 0; end
            if h,   cprintf([0,1,0],'d-prime (%d) = %+0.2f ± %0.2f \n',level,m_prime,s_prime);
            else    cprintf([1,0,0],'d-prime (%d) = %+0.2f ± %0.2f \n',level,m_prime,s_prime);
            end
        end
    end

end
