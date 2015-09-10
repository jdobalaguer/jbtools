
function obj = viewer_update(obj)
    %% obj = VIEWER_UPDATE(obj)

    %% function
    disp('viewer_update');
    
    h = obj.fig.viewer.figure;
    
    % axes
    obj = viewer_update_axes(obj);
    
    % map
    obj = viewer_update_map(obj);
    
    % line
    obj = viewer_update_line(obj);
    
    % appearance
    obj = viewer_update_appearance(obj);
    
    % callback
    obj = viewer_update_callback(obj);
    
    % whatever
    % TODO
    
    % figure
    viewer_check = findobj(obj.fig.control.figure,'Tag','ViewerCheck');
    set(h,'Visible',bool2string(get(viewer_check,'Value')));
end

function s = bool2string(b)
    s = 'off';
    if b, s = 'on'; end
end
