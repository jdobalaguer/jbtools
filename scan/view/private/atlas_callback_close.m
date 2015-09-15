
function obj = atlas_callback_close(obj,atlas)
    %% obj = ATLAS_CALLBACK_CLOSE(obj,atlas)

    %% function
    disp('atlas_callback_close');
    
    set(atlas,'Visible','off');
    obj = atlas_update_check(obj,'atlas');
end
