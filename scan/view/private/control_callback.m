
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
    merged_check = findobj(h,'Tag','MergedCheck'); set(merged_check,'Callback',@callbackMerged);
    
    % file
    file_list    = findobj(h,'Tag','FileList');    set(file_list,'Callback',@callbackFile);
    
    % position
    x_edit = findobj(h,'Tag','XEdit');             set(x_edit,'Callback',@callbackPosition);
    y_edit = findobj(h,'Tag','YEdit');             set(y_edit,'Callback',@callbackPosition);
    z_edit = findobj(h,'Tag','ZEdit');             set(z_edit,'Callback',@callbackPosition);
    bg_pop = findobj(h,'Tag','BackgroundPopup');   set(bg_pop,'Callback',@callbackPosition);
    
    %% nested control callback
    function closeControl(~,~)
        disp('close_control');
        destructor(obj);
    end

    %% nested windows callback
    function callbackViewer(check,~)
        disp('switchViewer');
        if check.Value, set(obj.fig.viewer.figure,'Visible','on');
        else            set(obj.fig.viewer.figure,'Visible','off');
        end
    end
    function callbackGlass(check,~)
        disp('switchGlass');
        if check.Value, set(obj.fig.glass.figure,'Visible','on');
        else            set(obj.fig.glass.figure,'Visible','off');
        end
    end
    function callbackMask(check,~)
        disp('switchMask');
        if check.Value, set(obj.fig.mask.figure,'Visible','on');
        else            set(obj.fig.mask.figure,'Visible','off');
        end
    end
    function callbackAtlas(check,~)
        disp('switchAtlas');
        if check.Value, set(obj.fig.atlas.figure,'Visible','on');
        else            set(obj.fig.atlas.figure,'Visible','off');
        end
    end
    function callbackMerged(check,~)
        disp('switchMerged');
        if check.Value, set(obj.fig.merged.figure,'Visible','on');
        else            set(obj.fig.merged.figure,'Visible','off');
        end
    end

    %% nested file callback
    function callbackFile(~,~)
        obj = viewer_update(obj);
    end

    %% nested Statistics callback
    function callbackStat(~,~)
        obj = viewer_update(obj);
    end

    %% nested position callback
    function callbackPosition(~,~)
        obj = viewer_update(obj);
    end
end
