
function obj = viewer_callback_key(obj,evt)
    %% obj = VIEWER_CALLBACK_KEY(obj,evt)

    %% function
    disp('viewer_callback_key');

    % apply key
    [dx,dy,dz] = deal(0,0,0);
    switch strcat(sprintf('%s:',evt.Modifier{:}),evt.Key)
        
        % normal position
        case 'leftarrow',        dx = -1; 
        case 'rightarrow',       dx = +1;
        case 'pageup',           dy = +1;
        case 'pagedown',         dy = -1;
        case 'uparrow',          dz = +1;
        case 'downarrow',        dz = -1;
            
        % quick position
        case 'shift:leftarrow',  dx = -5;
        case 'shift:rightarrow', dx = +5;
        case 'shift:pageup',     dy = +5;
        case 'shift:pagedown',   dy = -5;
        case 'shift:uparrow',    dz = +5;
        case 'shift:downarrow',  dz = -5;
            
        % slow position
        case 'alt:leftarrow',    dx = -0.2;
        case 'alt:rightarrow',   dx = +0.2;
        case 'alt:uparrow',      dz = +0.2;
        case 'alt:downarrow',    dz = -0.2;
        case 'alt:pageup',       dy = +0.2;
        case 'alt:pagedown',     dy = -0.2;
        
        % find global/local maximum/minimum
        case 'g',                obj = viewer_callback_maximum(obj,false,+1);
        case 'shift:g',          obj = viewer_callback_maximum(obj,false,-1);
        case 'l',                obj = viewer_callback_maximum(obj,true, +1);
        case 'shift:l',          obj = viewer_callback_maximum(obj,true, -1);
            
        % find global/local maximum/minimum
        case 'p',                obj = viewer_callback_tail(obj,'p');
        case 'n',                obj = viewer_callback_tail(obj,'n');
        case 'b',                obj = viewer_callback_tail(obj,'b');
            
        % nothing
        otherwise, return;
    end
    
    control_update_position(obj,dx,dy,dz);
    obj = viewer_update(obj);
end
