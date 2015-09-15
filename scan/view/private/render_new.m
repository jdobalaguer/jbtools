
function obj = render_new(obj)
    %% obj = RENDER_NEW(obj)

    %% function
    disp('render_new');
    
    % figure
    h = figure();
    set(h,'Name',           'Render');
    set(h,'Tag',            'RenderFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'off');
    obj.fig.render.figure = h;
end
