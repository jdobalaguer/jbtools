
function obj = viewer_create(obj)
    %% obj = VIEWER_CREATE(obj)

    %% function
    disp('viewer_create');
    
    % axes
    obj = viewer_create_axes(obj);
    
    % map
    obj = viewer_create_background(obj);
    obj = viewer_create_statistics(obj);
    
    % line
    obj = viewer_create_line(obj);
    
    % appearance
    obj = viewer_create_appearance(obj);
    obj = viewer_update_XYlim(obj);
    
    % callback
    obj = viewer_create_callback(obj);
end
