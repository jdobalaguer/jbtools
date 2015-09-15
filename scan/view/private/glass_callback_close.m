
function obj = glass_callback_close(obj,glass)
    %% obj = GLASS_CALLBACK_CLOSE(obj,glass)

    %% function
    disp('glass_callback_close');
    
    set(glass,'Visible','off');
    obj = glass_update_check(obj,'glass');
end
