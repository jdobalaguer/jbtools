
function obj = viewer_update(obj)
    %% obj = VIEWER_UPDATE(obj)

    %% function
    disp('viewer_update');
    
    % text
    obj = viewer_update_text(obj);
    
    % background
    obj = viewer_update_background(obj);

    % statistics
    obj = viewer_update_statistics(obj);
    
    % line
    obj = viewer_update_line(obj);
end
