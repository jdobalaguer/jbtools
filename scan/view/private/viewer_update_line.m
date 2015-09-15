
function obj = viewer_update_line(obj)
    %% obj = VIEWER_UPDATE_LINE(obj)

    %% function
    disp('viewer_update_line');
    
    % coordinate
    x = str2double(get(findobj(obj.fig.control.figure,'Tag','XEdit'),'String'));
    y = str2double(get(findobj(obj.fig.control.figure,'Tag','YEdit'),'String'));
    z = str2double(get(findobj(obj.fig.control.figure,'Tag','ZEdit'),'String'));
    [xbox,ybox,zbox] = viewer_get_XYlim(obj);
    
    % print background
    set(obj.fig.viewer.line.x(1,:),'XData',ybox, 'YData',[z,z]);
    set(obj.fig.viewer.line.y(1,:),'XData',[y,y],'YData',zbox );
    
    set(obj.fig.viewer.line.x(2,:),'XData',xbox, 'YData',[z,z]);
    set(obj.fig.viewer.line.y(2,:),'XData',[x,x],'YData',zbox );
    
    set(obj.fig.viewer.line.x(3,:),'XData',ybox, 'YData',[x,x]);
    set(obj.fig.viewer.line.y(3,:),'XData',[y,y],'YData',xbox );
end
