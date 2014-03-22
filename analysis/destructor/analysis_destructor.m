%  ANALYSIS internal script
fprintf('analysis_destructor: \n');

%% destructor
analysis_destructor_close;  % close all figures
delete(gcbf);delete(obj);   % delete
