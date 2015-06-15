
function cf = fig_figure(cf)
    %% fig_figure(cf)
    % create and/or set figure [cf]
    
    %% function
    
    % default
    func_default('cf',figure());
    
    % colour
    set(cf,'Color',[1,1,1]);
    
    % smooth
    % fig_smooth(cf);
    
    % toolbar
    set(cf,'ToolBar','none');
    
    % hold
    hold('on');
    
    % docked
    % set(cf,'WindowStyle','docked');
end
