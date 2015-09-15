
function obj = mask_callback_close(obj,mask)
    %% obj = MASK_CALLBACK_CLOSE(obj,mask)

    %% function
    disp('mask_callback_close');
    
    set(mask,'Visible','off');
    obj = mask_update_check(obj,'mask');
end
