%  ANALYSIS internal script

%% new figure

% create figure
h = figure('CloseRequestFcn',@obj.figure_closed);
fig_figure(h);

% create struct;
fig = struct();
fig.handle = h;
fig.name   = '';

% set figure
obj.fig{end+1} = fig;
