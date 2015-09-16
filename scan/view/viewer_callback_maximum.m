
function obj = viewer_callback_maximum(obj,local,sign)
    %% obj = VIEWER_CALLBACK_MAXIMUM(obj,local,sign)
    
    %% function
    disp('viewer_callback_maximum');
    
    % find file (based on current axis
    ii_file = any(gca() == obj.fig.viewer.axis,1);
    if ~any(ii_file), return; end
    u_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    
    % get volume
    mni    = obj.dat.statistics(u_file(ii_file)).mni;
    volume = obj.dat.statistics(u_file(ii_file)).data;
    
    % apply sign
    volume = sign .* volume;
    
    % handle control
    h = obj.fig.control.figure;
    x_edit = findobj(h,'Tag','XEdit');
    y_edit = findobj(h,'Tag','YEdit');
    z_edit = findobj(h,'Tag','ZEdit');
    
    % get coordinates
    x = str2double(get(x_edit,'String'));
    y = str2double(get(y_edit,'String'));
    z = str2double(get(z_edit,'String'));
    
    if local
        % local maximum
        % TODO
    else
        % global maximum
        volume = volume(:);
        m = max(volume);
        f = find(volume == m);
        f = f(randi(length(f)));
        x = mni.x(f);
        y = mni.y(f);
        z = mni.z(f);
    end

    % update control
    set(x_edit,'String',sprintf('%.1f',x));
    set(y_edit,'String',sprintf('%.1f',y));
    set(z_edit,'String',sprintf('%.1f',z));
end
