
function obj = glass_new(obj)
    %% obj = GLASS_NEW(obj)

    %% function
    disp('glass_new');
    
    % figure
    h = figure();
    set(h,'Name',           'Brain Glass');
    set(h,'Tag',            'ControlFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'off');
    set(h,'CloseRequestFcn',@closeGlass);
    if ~obj.par.control.windows.glass, set(h,'Visible','off'); end
    obj.fig.glass.figure = h;
    
    %% nested function
    function closeGlass(~,~)
        disp('close_glass');
        set(h,'Visible','off');
        check = findobj(obj.fig.control.figure,'Tag','GlassCheck');
        set(check,'Value',0);
    end
end
