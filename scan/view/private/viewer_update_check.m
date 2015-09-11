
function obj = viewer_update_check(obj,from)
    %% obj = VIEWER_UPDATE_CHECK(obj,from)
    
    %% function
    disp('viewer_update_check');
    
    % handles
    check  = findobj(obj.fig.control.figure,'Tag','ViewerCheck');
    viewer = obj.fig.viewer.figure;
    
    % get value
    switch from
        case 'control', b = get(check,'Value');
        case 'viewer',  b = aux_string2bool(get(viewer,'Visible'));
        otherwise,      scan_tool_error(obj.dat.scan,'from "%s" not recognised',from);
    end
    
    % update
    set(check, 'Value',b);
    set(viewer,'Visible',aux_bool2string(b));
end
