
function fig_cloneplot(fa,tf,sp)
    %% FIG_CLONEPLOT(hf,ht)
    % clone a (sub)plot from one figure to another figure
    
    %% function
    
    % assert
    assertLength(fig_list());
    
    % default
    func_default('fa',gca());
    func_default('tf',[]);
    if isempty(tf), tf = fig_figure(); end
    func_default('sp', [1,1,1]);
    
    % subplot
    figure(tf);
    ta = subplot(sp(1),sp(2),sp(3));
    
    % clone
    children = get(fa,'children');
    copyobj(children,ta);
end
