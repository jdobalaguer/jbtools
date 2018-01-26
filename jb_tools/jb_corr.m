%% jb_ttest

%% warnings
%#ok<*ASGLU>

%% function
function varargout = jb_corr(varargin)
    [rho,pval] = corr(varargin{:});
    fprintf('rho = %+.2f, p = %.3f \n',rho,pval);
    stats.rho = rho;
    stats.p   = pval;
    if nargout,varargout = {stats}; end
end