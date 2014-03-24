% ANALYSIS internal script

%% switch visible
visible = get(obj.gfx.window.window,'Visible');
switch visible
    case 'on'
        set(obj.gfx.window.window,'Visible','off');
    case'off'
        set(obj.gfx.window.window,'Visible','on');
end

%% refresh gui
obj.obj.graphics.refresh();
