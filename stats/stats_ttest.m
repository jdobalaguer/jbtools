
function [h,p] = stats_ttest(x,y)
    %% [h,p] = STATS_TTEST(x,y)
    % non-parametric unpaired ttest
    
    % should use [signrank] instead
    
    %% warnings
    
    %% function
    n_iteration = 1e4;
    s_x         = length(x);
    s_y         = length(y);
    
    h1 = mean(y)-mean(x);
    
%     [m1,m2] = meshgrid([x;y],[x;y]);
%     h0 = mat2vec(m1-m2);

    h0 = nan(n_iteration,1);
    null_c = [x;y];
    for i_iteration = 1:n_iteration
        null_c = shuffle(null_c);
        null_x = null_c(1:s_x);
        null_y = null_c(s_x+1:end);
        h0(i_iteration) = mean(null_y) - mean(null_x);
    end
    assignall();
    
    % probability
    p = mean(h0>=h1);
    h = (p < 0.05);
    
    % plot
    fig_figure();
    hold('on');
    hist(h0,-1:0.01:+1);
    plot(h1,0,'rx');
end