
function obj = atlas_update_check(obj,from)
    %% obj = ATLAS_UPDATE_CHECK(obj,from)
    
    %% function
    disp('atlas_update_check');
    
    % handles
    check  = findobj(obj.fig.control.figure,'Tag','AtlasCheck');
    atlas = obj.fig.atlas.figure;
    
    % get value
    switch from
        case 'control', b = get(check,'Value');
        case 'atlas',   b = aux_string2bool(get(atlas,'Visible'));
        otherwise,      scan_tool_error(obj.dat.scan,'from "%s" not recognised',from);
    end
    
    % update
    set(check,'Value',b);
    set(atlas,'Visible',aux_bool2string(b));
end
