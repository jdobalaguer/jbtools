
function obj = control_callback(obj)
    %% obj = CONTROL_CALLBACK(obj)

    %% function
    disp('control_callback');
    h = obj.fig.control.figure;
    
    % figure
    set(h,'CloseRequestFcn',@closeControl);
    
    % windows
    viewer_check = findobj(h,'Tag','ViewerCheck'); set(viewer_check,'Callback',@callbackViewer);
%     glass_check  = findobj(h,'Tag','GlassCheck');  set(glass_check, 'Callback',@callbackGlass);
%     mask_check   = findobj(h,'Tag','MaskCheck');   set(mask_check,  'Callback',@callbackMask);
%     atlas_check  = findobj(h,'Tag','AtlasCheck');  set(atlas_check, 'Callback',@callbackAtlas);
%     merged_check = findobj(h,'Tag','MergedCheck'); set(merged_check,'Callback',@callbackMerged);
    
    % file
    file_list    = findobj(h,'Tag','FileList');    set(file_list,'Callback',@callbackFile);
    
    % statistics
    p_edit = findobj(h,'Tag','PValueEdit'); set(p_edit,'Callback',@callbackStatistics);
    t_edit = findobj(h,'Tag','StatEdit');   set(t_edit,'Callback',@callbackStatistics);
    f_edit = findobj(h,'Tag','FDREdit');    set(f_edit,'Callback',@callbackStatistics);
    d_edit = findobj(h,'Tag','DFEdit');     set(d_edit,'Callback',@callbackStatistics);
    
    % position
    x_edit = findobj(h,'Tag','XEdit');             set(x_edit,'Callback',@callbackPosition);
    y_edit = findobj(h,'Tag','YEdit');             set(y_edit,'Callback',@callbackPosition);
    z_edit = findobj(h,'Tag','ZEdit');             set(z_edit,'Callback',@callbackPosition);
    bg_pop = findobj(h,'Tag','BackgroundPopup');   set(bg_pop,'Callback',@callbackPosition);
    
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
%     function callbackGlass(check,~)
%         disp('control_callback.callbackGlass');
%         set(obj.fig.glass.figure,'Visible',aux_bool2string(get(check,'Value')));
%     end
%     function callbackMask(check,~)
%         disp('control_callback.callbackMask');
%         set(obj.fig.mask.figure,'Visible',aux_bool2string(get(check,'Value')));
%     end
%     function callbackAtlas(check,~)
%         disp('control_callback.callbackAtlas');
%         set(obj.fig.atlas.figure,'Visible',aux_bool2string(get(check,'Value')));
%     end
%     function callbackMerged(check,~)
%         disp('control_callback.callbackMerged');
%         set(obj.fig.merged.figure,'Visible',aux_bool2string(get(check,'Value')));
%     end

    %% nested file callback
    function callbackFile(~,~)
        disp('control_callback.callbackFile');
        obj = viewer_create(obj);
        obj = viewer_update(obj);
        obj = viewer_update_check(obj,'control');
    end

    %% nested statistics callback
    function callbackStatistics(edit,~)
        disp('control_callback.callbackStatistics');
        obj = control_update_statistics(obj,edit);
        obj = viewer_update_map(obj);
    end

    %% nested position callback
    function callbackPosition(~,~)
        disp('control_callback.callbackPosition');
        obj = control_update_position(obj,0,0,0);
        obj = viewer_update(obj);
    end
end
