%  ANALYSIS internal script

%% index figures
ii_fig = [];

nb_fig = length(obj.fig);
u_fig  = cell(1,nb_fig);
for i_fig = 1:nb_fig
    if (obj.fig{i_fig}.handle == gcbf)
        ii_fig(end+1) = i_fig;
    end
end

%% remove figures
u_fig(ii_fig) = [];
obj.fig = u_fig;

%% refresh gui
obj.obj.figure.refresh();

%% close figure
delete(gcbf);

