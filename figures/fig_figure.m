
function cf = fig_figure(cf)
    %% fig_figure(cf)
    % create and/or set figure [cf]
    
    %% function
    
    % default
    func_default('cf',[]);
    if isempty(cf), cf = figure(); end
    if ~ismember(cf,double(fig_list)), figure(cf); end
    
    % colour
    set(cf,'Color',[1,1,1]);
    
    % smooth
    % fig_smooth(cf);
    
    % toolbar
    set(cf,'ToolBar','none');
    
    % hold
    hold('on');
end
