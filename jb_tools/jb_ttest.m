%% jb_ttest

%% warnings
%#ok<*ASGLU>

%% function
function varargout = jb_ttest(varargin)
    [h,p,ci,stats] = ttest(varargin{:});
    fprintf('t(%d) = %+.2f, p = %.3f \n',stats.df,stats.tstat,p);
    stats.h  = h;
    stats.ci = ci;
    stats.p  = p;
    if nargout,varargout = {stats}; end
end