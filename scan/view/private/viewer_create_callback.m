
function obj = viewer_create_callback(obj)
    %% obj = VIEWER_CREATE_CALLBACK(obj)

    %% function
    disp('viewer_create_callback');
    
    % print background
    set(obj.fig.viewer.axis,      'ButtonDownFcn',@clickSurface);
    set(obj.fig.viewer.background,'ButtonDownFcn',@clickSurface);
    set(obj.fig.viewer.statistics,'ButtonDownFcn',@clickSurface);
    set(obj.fig.viewer.line.x,    'ButtonDownFcn',@clickSurface);
    set(obj.fig.viewer.line.y,    'ButtonDownFcn',@clickSurface);
    
    %% nested function
    function clickSurface(s,e)
        disp('clickSurface');
        
        %  get axis and POV
        if strcmp(get(s,'Type'),'axes') a = s;
        else                            a = get(s,'Parent');
        end
        i_pov = find(any(obj.fig.viewer.axis == a,2));
        
        % update control
        coord = round(e.IntersectionPoint(1:2));
        h = obj.fig.control.figure;
        switch i_pov
            case 1
                y_edit = findobj(h,'Tag','YEdit'); set(y_edit,'String',sprintf('%.1f',coord(1)));
                z_edit = findobj(h,'Tag','ZEdit'); set(z_edit,'String',sprintf('%.1f',coord(2)));
            case 2
                x_edit = findobj(h,'Tag','XEdit'); set(x_edit,'String',sprintf('%.1f',coord(1)));
                z_edit = findobj(h,'Tag','ZEdit'); set(z_edit,'String',sprintf('%.1f',coord(2)));
            case 3
                x_edit = findobj(h,'Tag','XEdit'); set(x_edit,'String',sprintf('%.1f',coord(2)));
                y_edit = findobj(h,'Tag','YEdit'); set(y_edit,'String',sprintf('%.1f',coord(1)));
        end
        
        % update viewer
        obj = viewer_update(obj);
    end
end
