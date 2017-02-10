%% jb_ttest2

%% warnings
%#ok<*ASGLU>

%% function
function varargout = jb_ttest2(varargin)
    [h,p,ci,stats] = ttest2(varargin{:});
    fprintf('t(%d) = %.2f, p = %.3f \n',stats.df,stats.tstat,p);
    if nargout, varargout = {stats}; end
end