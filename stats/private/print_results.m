
function print_results(stats,m)
    %% PRINT_RESULTS(pars,stats)
    % auxiliar function
    
    %% function
    func_default('m','publish this');
    
    if stats.h, cprintf('*Comments',      sprintf('We can %s! \n',m));
    else        cprintf('*SystemCommands',sprintf('Cannot %s. \n',m));
    end
    
    print_value(stats, 'p',   @(p)  abs(log10(p))>3,  'p-value               = ', '%.3e','%.3f');
    print_value(stats, 'hdi', @(hdi)true,             'High-density interval = ', '[%.3f,%.3f]','');
    print_value(stats, 'bf',  @(bf) abs(log10(bf))>2, 'Bayes factor          = ', '%.2e','%.2f');
end

%% auxiliar
function print_value(s,f,b,m,mt,mf)
    if ~struct_isfield(s,f), return; end
    v = s.(f);
    if b(v), fprintf([m,mt,'\n'],v);
    else     fprintf([m,mf,'\n'],v);
    end
end