%  ANALYSIS internal script
fprintf('analysis_figure_closeall: \n');

%% close all
h_analysis = gcf();
h_figures  = get(0,'Children');
h_figures(h_figures==h_analysis) = [];
for h_figure = h_figures
  close(h_figure);
end
