
function obj = control_update_position(obj,dx,dy,dz)
    %% obj = CONTROL_UPDATE_POSITION(obj,dx,dy,dz)
    
    %% function
    disp('control_update_position');
    
    % handle control
    h = obj.fig.control.figure;
    x_edit = findobj(h,'Tag','XEdit');
    y_edit = findobj(h,'Tag','YEdit');
    z_edit = findobj(h,'Tag','ZEdit');

    % get coordinates
    x = dx + str2double(get(x_edit,'String'));
    y = dy + str2double(get(y_edit,'String'));
    z = dz + str2double(get(z_edit,'String'));

    % limit coordinates
    [xbox,ybox,zbox] = viewer_get_XYlim(obj);
    xyz = [x,y,z];
    xyz = max(xyz,[xbox(1),ybox(1),zbox(1)]);
    xyz = min(xyz,[xbox(2),ybox(2),zbox(2)]);
    x = xyz(1); y = xyz(2); z = xyz(3);

    % update control
    set(x_edit,'String',sprintf('%+.1f',x));
    set(y_edit,'String',sprintf('%+.1f',y));
    set(z_edit,'String',sprintf('%+.1f',z));
end
