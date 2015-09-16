
function obj = viewer_new(obj)
    %% obj = VIEWER_NEW(obj)

    %% function
    disp('viewer_new');

    % figure
    h = figure();
    set(h,'Name',           'Viewer');
    set(h,'Tag',            'ViewerFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'on');
    set(h,'Color',          [0,0,0]);
    obj.fig.viewer.figure = h;
    
    % axis
    obj.fig.viewer.axis  = [];
    obj.fig.viewer.text.title = [];
    obj.fig.viewer.text.pvalue = [];
    obj.fig.viewer.text.statistic = [];
    
    % background
    obj.fig.viewer.background = [];
    
    % statistics
    obj.fig.viewer.statistics = [];
    
    % line
    obj.fig.viewer.line.x = [];
    obj.fig.viewer.line.y = [];

end
