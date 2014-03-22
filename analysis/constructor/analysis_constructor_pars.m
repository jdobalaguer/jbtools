%  ANALYSIS internal script
fprintf('analysis_constructor_pars: \n');

%% GRAPHICAL USER INTERFACE
obj.gui = struct();
obj.gui.background = [.8 .8 .8];
obj.gui.position = [0,0];
obj.gui.size = [350,950];

obj.gui.title           = [nan,15];
obj.gui.labels          = [nan,10];
obj.gui.figurebutton    = [40,24];
obj.gui.sdatabutton     = [40,24];
obj.gui.plotlistbox     = [nan,100];
obj.gui.plotlabel       = [40,24];
obj.gui.plotpushutton   = [40,24];
obj.gui.plotcheckbox    = [24,24];
obj.gui.plotpushbutton  = [24,40];
obj.gui.exportbutton    = [40,24];

obj.gui.space = 10;
obj.gui.space_figure = 7.5;
obj.gui.space_sdata  = 7.5;
obj.gui.space_plot   = 7.5;
obj.gui.space_export = 7.5;

%% OBJECT
obj.obj = struct();

%% FIGURES
obj.fig = {};
