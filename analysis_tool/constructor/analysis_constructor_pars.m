%  ANALYSIS internal script

%% GUI
obj.gui = struct();

obj.gui.win_background  = [.8 .8 .8];
obj.gui.win_position    = [0,0];
obj.gui.win_size        = [250,nan];

obj.gui.size_checkbox   = [24,24];
obj.gui.size_holdbutton = [40,24];
obj.gui.size_listbox    = [nan,24];
obj.gui.size_label      = [40,24];
obj.gui.size_pushbutton = [80,24];
obj.gui.size_space      = 10;
obj.gui.size_panellabel = 10;
obj.gui.size_title      = [nan,15];

%% OBJECT
obj.obj = struct();
obj.obj.window = [];
obj.obj.panels = struct();

%% FIGURES
obj.fig = {};
