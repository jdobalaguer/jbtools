
function cf = fig_figure(cf)
    %% fig_figure(cf)
    % 
    % create and/or set figure [cf]
    % 
    
    %% default
    if ~exist('cf','var')||isempty(cf); cf = figure(); end
    
    %% colour
    set(cf,'Color',[1,1,1]);
    
    %% smooth
    fig_smooth(cf);
    
    %% text
    fig_fontname(cf,'Verdana');
    fig_fontsize(cf,18);
    
    %% toolbar
    set(cf,'ToolBar','none');
    
    %% docked
    %set(cf,'WindowStyle','docked');
    
end
