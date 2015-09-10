
function obj = viewer_update_callback(obj)
    %% obj = VIEWER_UPDATE_CALLBACK(obj)

    %% function
    disp('viewer_update_map');
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % print background
    for i_pov = 1:3
        for i_file = 1:n_file
            set(obj.fig.viewer.background(i_pov,i_file),'ButtonDownFcn',@clickStatistics);
            set(obj.fig.viewer.statistics(i_pov,i_file),'ButtonDownFcn',@clickStatistics);
        end
    end
    
    %% nested function
    function clickStatistics(s,e)
        f_pov = find(any(obj.fig.viewer.axis == get(s,'Parent'),2));
        
        % update control
        coord = round(e.IntersectionPoint(1:2));
        h = obj.fig.control.figure;
        switch f_pov
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
        obj = viewer_update_map(obj);
        obj = viewer_update_line(obj);
        obj = viewer_update_appearance(obj);
        obj = viewer_update_callback(obj);
    end
end
