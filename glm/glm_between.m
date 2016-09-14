
function varargout = glm_between(a,m,o)
    %% [h,p,ci,stats] = GLM_BETWEEN(a,m,o)
    % Perform between-subject glm statistics
    % 
    % s : struct            : data
    % m : struct            : model
    % o : struct            : options
    % a : vector of structs : estimation

    %% function
    
    % default model
    m = struct_default(m,glm_model());
    if isempty(m.model), m.model = eye(length(m.regressor)); end
    
    % default options
    func_default('o',[]);
    o = struct_default(o,glm_options());
    
    % between-subject analyses
    [h,p,ci,stats] = ttest(cat(2,a.beta)');
    if nargout, varargout = {h,p,ci,stats}; return; end
    
    % print
    for i_stats = 1:length(stats.tstat)
        fprintf('t(%d) = %+8.2f, p = %.4f \n',stats.df(i_stats),stats.tstat(i_stats),p(i_stats));
    end
end
