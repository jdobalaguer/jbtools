%  ANALYSIS internal script

%% create window
obj.gfx.window   = analysis_gfx_window(obj);

%% create panels
obj.gfx.title    = analysis_gfx_title(obj);
obj.gfx.style    = analysis_gfx_style(obj);
obj.gfx.colour   = analysis_gfx_colour(obj);

%% resize window
obj.gfx.window.resize_window(obj);
obj.gfx.window.reposition_window();

%% reposition panels
obj.gfx.title.reposition(obj);
obj.gfx.style.reposition(obj);

%% show window
obj.gfx.window.show_window();
