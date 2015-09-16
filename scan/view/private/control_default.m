
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
    render_check = findobj(h,'Tag','RenderCheck'); set(render_check,'Value',p.render);
    
    % file
    file_list = findobj(h,'Tag','FileList');
    set(file_list,'Min',  0);
    set(file_list,'Max',  length(obj.dat.statistics));
    set(file_list,'Value',obj.par.control.file.selected);
    set(file_list,'String',file_next(file_2local({obj.dat.statistics.file})));
    
    % statistics
    set(findobj(h,'Tag','StatEdit'),  'String',sprintf('%.1e',obj.par.control.statistics.stat));
    set(findobj(h,'Tag','PValueEdit'),'String',sprintf('%.1e',obj.par.control.statistics.pvalue));
    set(findobj(h,'Tag','FDREdit'),   'String',sprintf('%.1e',obj.par.control.statistics.fdr));
    obj = control_update_map(obj);
    obj = control_update_df(obj);
    obj = control_update_tail(obj,[]);
    obj = control_update_statistics(obj);
    
    % position
    p = obj.par.control.position;
    x_edit = findobj(h,'Tag','XEdit'); set(x_edit,'String',sprintf('%.1f',p.x));
    y_edit = findobj(h,'Tag','YEdit'); set(y_edit,'String',sprintf('%.1f',p.y));
    z_edit = findobj(h,'Tag','ZEdit'); set(z_edit,'String',sprintf('%.1f',p.z));
    
    % background
    bg_pop  = findobj(h,'Tag','BackgroundPopup');   set(bg_pop,'String',{obj.dat.background.name},'Value',find(strcmp(obj.par.control.background.name,{obj.dat.background.name})));
    bgr_pop = findobj(h,'Tag','BgResolutionPopup'); set(bgr_pop,'String',{'Low','Med','High'},'Value',find(strcmp(obj.par.control.background.resolution,{'Low','Med','High'})));
end
