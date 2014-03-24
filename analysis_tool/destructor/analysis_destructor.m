%  ANALYSIS internal script

%% destructor
analysis_figure_closeall;      % close all figures
delete(obj.gfx.window.window); % close gfx
delete(obj.obj.window.window); % close gui
delete(obj);   % delete
