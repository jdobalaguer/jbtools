
function obj = control_update(obj)
    %% obj = CONTROL_UPDATE(obj)

    %% function
    disp('control_update');
    
    h = obj.fig.control.figure;
    
    % windows
    p = obj.par.control.windows;
    viewer_check = findobj(h,'Tag','ViewerCheck'); set(viewer_check,'Value',aux_string2bool(get(obj.fig.viewer.figure,'Visible')));
    glass_check  = findobj(h,'Tag','GlassCheck');  set(glass_check, 'Value',aux_string2bool(get(obj.fig.glass.figure, 'Visible')));
    mask_check   = findobj(h,'Tag','MaskCheck');   set(mask_check,  'Value',aux_string2bool(get(obj.fig.mask.figure,  'Visible')));
    atlas_check  = findobj(h,'Tag','AtlasCheck');  set(atlas_check, 'Value',aux_string2bool(get(obj.fig.atlas.figure, 'Visible')));
    merged_check = findobj(h,'Tag','MergedCheck'); set(merged_check,'Value',aux_string2bool(get(obj.fig.merged.figure,'Visible')));

    % files
    file_list = findobj(obj.fig.control.figure,'Tag','FileList');
    set(file_list,'String',file_2local(obj.dat.file));
    
    % statistics
    % (it has been already updated in control_default)
    
    % position
    obj = control_update_position(obj,0,0,0);
end
