
function obj = new_figures(obj)
    %% obj = new_figures(obj)

    %% function
    disp('new_figures');
    
    % load
    obj = control_load(obj);

    % new
    obj = control_new(obj);
    obj = viewer_new(obj);
    obj = glass_new(obj);
    obj = mask_new(obj);
    obj = atlas_new(obj);
    obj = render_new(obj);
    
    % default
    obj = control_default(obj);
    obj = viewer_default(obj);
    obj = glass_default(obj);
    obj = mask_default(obj);
    obj = atlas_default(obj);
    obj = render_default(obj);

    % callback
    obj = control_callback(obj);
    obj = viewer_callback(obj);
    obj = glass_callback(obj);
    obj = mask_callback(obj);
    obj = atlas_callback(obj);
    obj = render_callback(obj);

    % create
    obj = viewer_create(obj);
    
    % update
    obj = control_update(obj);
    obj = viewer_update(obj);
end
