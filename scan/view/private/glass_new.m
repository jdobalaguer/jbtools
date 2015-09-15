
function obj = glass_new(obj)
    %% obj = GLASS_NEW(obj)

    %% function
    disp('glass_new');
    
    % figure
    h = figure();
    set(h,'Name',           'Glass Brain');
    set(h,'Tag',            'GlassFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'off');
    obj.fig.glass.figure = h;
end
