
function obj = viewer_callback_close(obj,viewer)
    %% obj = VIEWER_CALLBACK_CLOSE(obj,viewer)

    %% function
    disp('viewer_callback_close');
    
    set(viewer,'Visible','off');
    obj = viewer_update_check(obj,'viewer');
end
