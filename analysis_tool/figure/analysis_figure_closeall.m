%  ANALYSIS internal script

%% close figures
h_analysis = obj.obj.window.window;
u_fig      = obj.fig;
nb_fig     = length(u_fig);

for i_fig = 1:nb_fig
    try delete(u_fig{i_fig}.handle); end %#ok<TRYNC>
end
