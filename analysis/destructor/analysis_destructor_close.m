%  ANALYSIS internal script
fprintf('analysis_destructor_close: \n');

%% figures
for i_fig = 1:length(obj.fig)
    delete(obj.fig{i_fig}.handle);
end

%% window
delete(obj);
