
function obj = render_update_check(obj,from)
    %% obj = RENDER_UPDATE_CHECK(obj,from)
    
    %% function
    disp('render_update_check');
    
    % handles
    check  = findobj(obj.fig.control.figure,'Tag','RenderCheck');
    render = obj.fig.render.figure;
    
    % get value
    switch from
        case 'control', b = get(check,'Value');
        case 'render',  b = aux_string2bool(get(render,'Visible'));
        otherwise,      scan_tool_error(obj.dat.scan,'from "%s" not recognised',from);
    end
    
    % update
    set(check, 'Value',b);
    set(render,'Visible',aux_bool2string(b));
end
