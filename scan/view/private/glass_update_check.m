
function obj = glass_update_check(obj,from)
    %% obj = GLASS_UPDATE_CHECK(obj,from)
    
    %% function
    disp('glass_update_check');
    
    % handles
    check = findobj(obj.fig.control.figure,'Tag','GlassCheck');
    glass = obj.fig.glass.figure;
    
    % get value
    switch from
        case 'control', b = get(check,'Value');
        case 'glass',   b = aux_string2bool(get(glass,'Visible'));
        otherwise,      scan_tool_error(obj.dat.scan,'from "%s" not recognised',from);
    end
    
    % update
    set(check,'Value',b);
    set(glass,'Visible',aux_bool2string(b));
end
