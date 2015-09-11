
function obj = viewer_update(obj)
    %% obj = VIEWER_UPDATE(obj)

    %% function
    disp('viewer_update');
    
    % map
    obj = viewer_update_map(obj);
    
    % line
    obj = viewer_update_line(obj);
end
