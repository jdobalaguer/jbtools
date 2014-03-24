%  ANALYSIS internal script

%% GUI
obj.par = struct();

obj.par.win_background  = [.8 .8 .8];
obj.par.win_position    = [0,0];
obj.par.win_size        = [250,nan];

obj.par.size_checkbox   = [24,24];
obj.par.size_holdbutton = [40,24];
obj.par.size_listbox    = [nan,24];
obj.par.size_label      = [40,24];
obj.par.size_pushbutton = [80,24];
obj.par.size_space      = 10;
obj.par.size_panellabel = 10;
obj.par.size_title      = [nan,15];

%% OBJECT
obj.obj = struct();
obj.obj.window = [];
obj.obj.panels = struct();

%% FIGURES
obj.fig = {};
