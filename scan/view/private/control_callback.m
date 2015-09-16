
function obj = control_callback(obj)
    %% obj = CONTROL_CALLBACK(obj)

    %% function
    disp('control_callback');
    h = obj.fig.control.figure;
    
    % figure
    set(h,'CloseRequestFcn',@closeControl);
    
    % windows
    viewer_check = findobj(h,'Tag','ViewerCheck'); set(viewer_check,'Callback',@callbackViewer);
    glass_check  = findobj(h,'Tag','GlassCheck');  set(glass_check, 'Callback',@callbackGlass);
    mask_check   = findobj(h,'Tag','MaskCheck');   set(mask_check,  'Callback',@callbackMask);
    atlas_check  = findobj(h,'Tag','AtlasCheck');  set(atlas_check, 'Callback',@callbackAtlas);
    render_check = findobj(h,'Tag','RenderCheck'); set(render_check,'Callback',@callbackRender);
    
    % file
    file_list    = findobj(h,'Tag','FileList');    set(file_list,'Callback',@callbackFile);
    
    % statistics
    p_edit = findobj(h,'Tag','PValueEdit'); set(p_edit,'Callback',@callbackStatistics);
    t_edit = findobj(h,'Tag','StatEdit');   set(t_edit,'Callback',@callbackStatistics);
    f_edit = findobj(h,'Tag','FDREdit');    set(f_edit,'Callback',@callbackStatistics);
    d_edit = findobj(h,'Tag','DFEdit');     set(d_edit,'Callback',@callbackStatistics);
    
    p_radio = findobj(h,'Tag','PositiveRadio');   set(p_radio,'Callback',@callbackTail);
    n_radio = findobj(h,'Tag','NegativeRadio');   set(n_radio,'Callback',@callbackTail);
    b_radio = findobj(h,'Tag','BothRadio');       set(b_radio,'Callback',@callbackTail);
    
    % position
    x_edit = findobj(h,'Tag','XEdit');              set(x_edit,'Callback',@callbackPosition);
    y_edit = findobj(h,'Tag','YEdit');              set(y_edit,'Callback',@callbackPosition);
    z_edit = findobj(h,'Tag','ZEdit');              set(z_edit,'Callback',@callbackPosition);
    
    bg_pop = findobj(h,'Tag','BackgroundPopup');    set(bg_pop,'Callback',@callbackBackground);
    bgr_pop = findobj(h,'Tag','BgResolutionPopup'); set(bgr_pop,'Callback',@callbackBgResolution);
    
    %% nested control callback
    function closeControl(~,~)
        disp('control_callback.close_control');
        destructor(obj);
    end

    %% nested windows callback
    function callbackViewer(~,~)
        disp('control_callback.callbackViewer');
        viewer_update_check(obj,'control');
    end
    function callbackGlass(~,~)
        disp('control_callback.callbackGlass');
        glass_update_check(obj,'control');
    end
    function callbackMask(~,~)
        disp('control_callback.callbackMask');
        mask_update_check(obj,'control');
    end
    function callbackAtlas(~,~)
        disp('control_callback.callbackAtlas');
        atlas_update_check(obj,'control');
    end
    function callbackRender(~,~)
        disp('control_callback.callbackRender');
        render_update_check(obj,'control');
    end

    %% nested file callback
    function callbackFile(~,~)
        disp('control_callback.callbackFile');
        obj = control_update_map(obj);
        obj = control_update_df(obj);
        obj = viewer_create(obj);
        obj = viewer_update(obj);
        obj = viewer_update_check(obj,'control');
    end

    %% nested statistics callback
    function callbackStatistics(edit,~)
        disp('control_callback.callbackStatistics');
        obj = control_update_statistics(obj,edit);
        obj = viewer_update_statistics(obj);
        obj = viewer_update_Clim(obj);
        obj = viewer_update_colormap(obj);
    end
    function callbackTail(radio,~)
        disp('control_callback.callbackTail');
        obj = control_update_tail(obj,radio);
        obj = control_update_statistics(obj);
        obj = viewer_update_statistics(obj);
        obj = viewer_update_Clim(obj);
        obj = viewer_update_colormap(obj);
    end

    %% nested position callback
    function callbackPosition(~,~)
        disp('control_callback.callbackPosition');
        obj = control_update_position(obj,0,0,0);
        obj = viewer_update(obj);
    end
    function callbackBackground(~,~)
        disp('control_callback.callbackBackground');
        obj = viewer_update_background(obj);
        obj = viewer_update_XYlim(obj);
    end
    function callbackBgResolution(~,~)
        disp('control_callback.callbackBackground');
        obj = viewer_update_background(obj);
    end
    
end
