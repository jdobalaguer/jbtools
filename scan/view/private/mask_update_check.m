
function obj = mask_update_check(obj,from)
    %% obj = MASK_UPDATE_CHECK(obj,from)
    
    %% function
    disp('mask_update_check');
    
    % handles
    check  = findobj(obj.fig.control.figure,'Tag','MaskCheck');
    mask = obj.fig.mask.figure;
    
    % get value
    switch from
        case 'control', b = get(check,'Value');
        case 'mask',  b = aux_string2bool(get(mask,'Visible'));
        otherwise,      scan_tool_error(obj.dat.scan,'from "%s" not recognised',from);
    end
    
    % update
    set(check,'Value',b);
    set(mask,'Visible',aux_bool2string(b));
end
