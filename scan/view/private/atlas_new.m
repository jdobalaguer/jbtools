
function obj = atlas_new(obj)
    %% obj = ATLAS_NEW(obj)

    %% function
    disp('atlas_new');
    
    % figure
    h = figure();
    set(h,'Name',           'Atlas');
    set(h,'Tag',            'AtlasFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'off');
    obj.fig.atlas.figure = h;
end
