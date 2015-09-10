
function obj = control_default(obj)
    %% obj = CONTROL_DEFAULT(obj)

    %% function
    disp('control_default');
    
    h = obj.fig.control.figure;
    
    % windows
    p = obj.par.control.windows;
    viewer_check = findobj(h,'Tag','ViewerCheck'); set(viewer_check,'Value',p.viewer);
    glass_check  = findobj(h,'Tag','GlassCheck');  set(glass_check, 'Value',p.glass);
    mask_check   = findobj(h,'Tag','MaskCheck');   set(mask_check,  'Value',p.mask);
    atlas_check  = findobj(h,'Tag','AtlasCheck');  set(atlas_check, 'Value',p.atlas);
    merged_check = findobj(h,'Tag','MergedCheck'); set(merged_check,'Value',p.merged);
    
    % file
    file_list = findobj(h,'Tag','FileList');
    set(file_list,'Min',  0);
    set(file_list,'Max',  obj.dat.number);
    set(file_list,'Value',obj.par.control.windows.selected);
    
    % statistics
    % TODO
    
    % position
    p = obj.par.control.position;
    x_edit = findobj(h,'Tag','XEdit'); set(x_edit,'String',sprintf('%.1f',p.x));
    y_edit = findobj(h,'Tag','YEdit'); set(y_edit,'String',sprintf('%.1f',p.y));
    z_edit = findobj(h,'Tag','ZEdit'); set(z_edit,'String',sprintf('%.1f',p.z));
    bg_pop = findobj(h,'Tag','BackgroundPopup'); set(bg_pop,'String',{obj.dat.templates.name});
end
