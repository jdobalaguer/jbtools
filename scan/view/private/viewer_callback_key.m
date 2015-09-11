
function obj = viewer_callback_key(obj,evt)
    %% obj = VIEWER_CALLBACK_KEY(obj,evt)

    %% function
    disp('viewer_callback_key');

    % apply key
    [dx,dy,dz] = deal(0,0,0);
    switch strcat(sprintf('%s:',evt.Modifier{:}),evt.Key)
        case 'leftarrow',        dx = -1;
        case 'rightarrow',       dx = +1;
        case 'uparrow',          dz = +1;
        case 'downarrow',        dz = -1;
        case 'pageup',           dy = +1;
        case 'pagedown',         dy = -1;
        case 'shift:leftarrow',  dx = -5;
        case 'shift:rightarrow', dx = +5;
        case 'shift:uparrow',    dz = +5;
        case 'shift:downarrow',  dz = -5;
        case 'shift:pageup',     dy = +5;
        case 'shift:pagedown',   dy = -5;
        otherwise, return;
    end

    % update controler
    control_update_position(obj,dx,dy,dz);

    % update viewer
    obj = viewer_update(obj);
end
