
function obj = viewer_new(obj)
    %% obj = VIEWER_NEW(obj)

    %% function
    disp('viewer_new');

    % figure
    h = figure();
    set(h,'Name',           'viewer');
    set(h,'Tag',            'ControlFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'on');
    obj.fig.viewer.figure = h;
    
    % axis
    obj.fig.viewer.axis = [];
    
    % background
    obj.fig.viewer.background = [];
    
    % statistics
    obj.fig.viewer.statistics = [];
    
    % line
    obj.fig.viewer.line.x = [];
    obj.fig.viewer.line.y = [];

end
