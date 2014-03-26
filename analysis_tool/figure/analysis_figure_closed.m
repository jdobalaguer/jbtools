%  ANALYSIS internal script

%% index figures
ii_fig = [];

nb_fig = length(obj.fig);
for i_fig = 1:nb_fig
    obj.fig
    if (obj.fig{i_fig}.handle == gcbf)
        ii_fig(end+1) = i_fig;
    end
end

%% remove figures
obj.fig(ii_fig) = [];

%% refresh gui
obj.obj.figure.refresh();

%% close figure
delete(gcbf);

