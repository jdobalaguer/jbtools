
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
end
