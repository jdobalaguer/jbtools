
function aux_switchWindow(obj,window)
    %% AUX_SWITCHWINDOW(obj,window)
    % switch focus to a certain window
    
    %% function
    
    % handle
    h = obj.fig.(window).figure;
    
    % make sure the figure is visible
    set(h,'Visible','on');
    
    % update check
    switch window
        case 'viewer', viewer_update_check(obj,window);
        case 'glass',  glass_update_check(obj,window);
        case 'mask',   mask_update_check(obj,window);
        case 'atlas',  atlas_update_check(obj,window);
        case 'render', render_update_check(obj,window);
    end
    
    % focus on figure
    figure(h);
    
end