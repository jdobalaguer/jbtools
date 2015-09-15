
function obj = viewer_create_appearance(obj)
    %% obj = VIEWER_CREATE_APPEARANCE(obj)
    % set the axes properties

    %% function
    disp('viewer_create_appearance');
    
    % appearance
    set(obj.fig.viewer.axis,'Visible','on');
    set(obj.fig.viewer.axis,'XTick',  []);
    set(obj.fig.viewer.axis,'YTick',  []);
    set(obj.fig.viewer.axis,'Box',    'on');
    set(obj.fig.viewer.axis,'XColor', [0,0,0]);
    set(obj.fig.viewer.axis,'YColor', [0,0,0]);
end
