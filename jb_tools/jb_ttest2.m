%% jb_ttest2

%% warnings
%#ok<*ASGLU>

%% function
function varargout = jb_ttest2(x1,x2)
    [h,p,ci,stats] = ttest2(x1,x2);
    fprintf('t(%d) = %.2f, p = %.3f \n',stats.df,stats.tstat,p);
    if nargout, varargout = {stats}; end
end