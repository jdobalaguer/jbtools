
function varargout = stats_meanova(x,l)
    %% [h,p,F,stats,lme] = STATS_MEANOVA(x[,l])
    % Linear mixed-effects ANOVA
    % x : matrix. the data, with one dimension per factor
    %             the first dimension correspond must correspond to subjects
    %             and nans for missing values
    % l : cell of strings. one label per factor
    
    %% function
    warning('Not sure how valid is this method - do *not* rely on this function for final statistics');
    
    varargout = {};
    
    % default
    func_default('l',num2cell(char('A'+(0:ndims(x)-2))));
    
    % assert
    if ismember('Target',strtrim(l)),  func_error('"Target"  is not a valid label'); end
    if ismember('Subject',strtrim(l)), func_error('"Subject" is not a valid label'); end

    % linear mixed-effects model
    [lme,effects] = stats_lme(x,l);
    
    % ANOVA
    stats = anova(lme,'dfmethod','satterthwaite');
    
    % return
    p   = stats.pValue(2:end);
    h   = (p < 0.05);
    F   = stats.FStat(2:end);
    dfd = stats.DF2(2:end);
    dfn = stats.DF1(2:end);
    
    % print
    if ~nargout
        for i = 1:numel(h)
            fprintf('Effect %02d: %-18s F(%3.2f,%3.2f)=%4.3f,\tp=%4.3f \n',i,effects{i},dfn(i),dfd(i),F(i),p(i));
        end
    else
        varargout = {h,p,F,stats,lme};
    end
    
end
