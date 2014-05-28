%% jb_ttest

%% warnings
%#ok<*ASGLU>

%% function
function jb_ttest(x)
    [h,p,ci,stats] = ttest(x);
    fprintf('t(%d) = %+.2f, p = %.3f \n',stats.df,stats.tstat,p);
end