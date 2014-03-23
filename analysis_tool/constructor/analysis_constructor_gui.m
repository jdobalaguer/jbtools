%  ANALYSIS internal script

%% create window
obj.obj.window   = analysis_gui_window(obj);

%% create panels
obj.obj.title    = analysis_gui_title(obj);
obj.obj.figure   = analysis_gui_figure(obj);
obj.obj.sdata    = analysis_gui_sdata(obj);
obj.obj.axis     = analysis_gui_axis(obj);
obj.obj.graphics = analysis_gui_graphics(obj);
obj.obj.plot     = analysis_gui_plot(obj);

%% resize window
obj.obj.window.resize_window(obj);

%% reposition panels
obj.obj.title.reposition(obj);
obj.obj.figure.reposition(obj);
obj.obj.sdata.reposition(obj);
obj.obj.axis.reposition(obj);
obj.obj.graphics.reposition(obj);
obj.obj.plot.reposition(obj);

%% show window
obj.obj.window.show_window();
