
function ta = fig_cloneplot(fa,tf,sp)
    %% FIG_CLONEPLOT(fa,tf,sp)
    % clone a (sub)plot from one figure to another figure
    % fa : figure axis to copy (e.g. gca)
    % tf : figure where you want to copy it (i.e. a figure handle - empty if you want a new figure)
    % sp : subplot in the new figure (e.g. [1,2,1] - empty if taking the whole figure)
    
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
