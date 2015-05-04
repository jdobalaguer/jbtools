
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
    
    %% toolbar
    set(cf,'ToolBar','none');
    
    %% hold
    hold('on');
    
    %% docked
    %set(cf,'WindowStyle','docked');
    
end
