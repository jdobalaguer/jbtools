
function ii_bg = control_get_background(obj)
    %% ii_bg = CONTROL_GET_BACKGROUND(obj)
    % get the selected background
    
    %% function
    disp('control_get_background');
    
    bg_popup = findobj(obj.fig.control.figure,'Tag','BackgroundPopup');
    ii_bg = get(bg_popup,'Value');
end
