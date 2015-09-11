
function obj = control_update_position(obj,dx,dy,dz)
    %% obj = CONTROL_UPDATE_POSITION(obj)
    
    %% function
    disp('control_update_position');
    
    % handle control
    h = obj.fig.control.figure;
    x_edit = findobj(h,'Tag','XEdit');
    y_edit = findobj(h,'Tag','YEdit');
    z_edit = findobj(h,'Tag','ZEdit');

    % get coordinates
    x = dx + eval(get(x_edit,'String'));
    y = dy + eval(get(y_edit,'String'));
    z = dz + eval(get(z_edit,'String'));

    % limit coordinates
    xyz = [x,y,z];
    xyz = max(xyz,[1,1,1]);
    xyz = min(xyz,obj.dat.size);
    x = xyz(1); y = xyz(2); z = xyz(3);

    % update control
    set(x_edit,'String',sprintf('%.1f',x));
    set(y_edit,'String',sprintf('%.1f',y));
    set(z_edit,'String',sprintf('%.1f',z));
end
