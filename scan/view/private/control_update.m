
function obj = control_update(obj)
    %% obj = CONTROL_UPDATE(obj)

    %% function
    disp('control_update');
    
    % windows
    viewer_update_check(obj,'control');
    glass_update_check(obj,'control');
    mask_update_check(obj,'control');
    atlas_update_check(obj,'control');
    render_update_check(obj,'control');

    % files
    % (files has been already updated in control_default)
    
    % statistics
    % (statistics/tail have been already updated in control_default)
    
    % position
    obj = control_update_position(obj,0,0,0);
end
