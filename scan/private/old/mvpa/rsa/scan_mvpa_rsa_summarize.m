
function scan = scan_mvpa_rsa_summarize(scan)
    %% scan = SCAN_MVPA_RSA_SUMMARIZE(scan)
    % Compute statistics (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW,*ASGLU>
    
    %% FUNCTION
    if scan.subject.n < 2, return; end
    
    % calculate statistics
    beta = [];
    for i_subject = 1:scan.subject.n
        b = [];
        for i_session = 1:length(scan.mvpa.result.rsa{i_subject})
            b(i_session,:) = scan.mvpa.result.rsa{i_subject}{i_session}.stats.beta;
        end
        beta(i_subject,:) = meeze(b);
    end
    [h,p,~,stats] = ttest(beta);
    
    % print
    for i_model = 2:length(h)
        if isnan(h(i_model)), h(i_model) = 0; end
        if h(i_model),  cprintf('*g','model "%s" significant',     scan.mvpa.variable.model{i_subject}{i_model-1}.name);
        else            cprintf('*r','model "%s" not significant', scan.mvpa.variable.model{i_subject}{i_model-1}.name);
        end
        fprintf('\n');
        fprintf('p-value        = %0.3f          \n',p(i_model));
        fprintf('t-statistic    = %+0.2f         \n',stats.tstat(i_model));
    end
end