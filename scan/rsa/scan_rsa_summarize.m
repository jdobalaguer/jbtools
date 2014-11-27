
function scan = scan_rsa_summarize(scan)
    %% scan = SCAN_RSA_SUMMARIZE(scan)
    % Compute statistics (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % calculate statistics
    beta = [];
    for i_subject = 1:scan.subject.n
        beta(end+1,:) = scan.rsa.result{i_subject}.stats.beta;
    end
    [h,p,~,stats] = ttest(beta);
    
    % concatenate names
    %TODO
    
    % print
    for i_model = 2:length(h)
        if isnan(h(i_model)), h(i_model) = 0; end
        if h,   cprintf('*g','model "%s" significant',     scan.rsa.variable.model{i_subject}{i_model-1}.name);
        else    cprintf('*r','model "%s" not significant', scan.rsa.variable.model{i_subject}{i_model-1}.name);
        end
        fprintf('\n');
        fprintf('p-value        = %0.3f          \n',p(i_model));
        fprintf('t-statistic    = %+0.2f         \n',stats.tstat(i_model));
    end
end