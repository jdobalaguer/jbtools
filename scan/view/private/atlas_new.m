
function obj = atlas_new(obj)
    %% obj = ATLAS_NEW(obj)

    %% function
    disp('atlas_new');
    
    % figure
    h = figure();
    set(h,'Name',           'Atlas');
    set(h,'Tag',            'ControlFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'off');
    set(h,'CloseRequestFcn',@closeAtlas);
    if ~obj.par.control.windows.atlas, set(h,'Visible','off'); end
    obj.fig.atlas.figure = h;
    
    %% nested function
    function closeAtlas(~,~)
        disp('close_atlas');
        set(h,'Visible','off');
        check = findobj(obj.fig.control.figure,'Tag','AtlasCheck');
        set(check,'Value',0);
    end
end
