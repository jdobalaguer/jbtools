
function obj = render_callback_close(obj,render)
    %% obj = RENDER_CALLBACK_CLOSE(obj,render)

    %% function
    disp('render_callback_close');
    
    set(render,'Visible','off');
    obj = render_update_check(obj,'render');
end
