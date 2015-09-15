
function [xbox,ybox,zbox] = viewer_get_XYlim(obj)
    %% obj = VIEWER_GET_XYLIM(obj)
    % get the limits of the figure
    
    %% function
    disp('viewer_get_XYlim');
    
    xlim = get(obj.fig.viewer.axis,'XLim');
    ylim = get(obj.fig.viewer.axis,'YLim');
    
    xmin = unique([xlim{2}(1),ylim{3}(1)]) + obj.par.viewer.marge;
    xmax = unique([xlim{2}(2),ylim{3}(2)]) - obj.par.viewer.marge;
    ymin = unique([xlim{1}(1),xlim{3}(1)]) + obj.par.viewer.marge;
    ymax = unique([xlim{1}(2),xlim{3}(2)]) - obj.par.viewer.marge;
    zmin = unique([ylim{1}(1),ylim{2}(1)]) + obj.par.viewer.marge;
    zmax = unique([ylim{1}(2),ylim{2}(2)]) - obj.par.viewer.marge;
    
    % output
    xbox = [xmin, xmax];
    ybox = [ymin, ymax];
    zbox = [zmin, zmax];
end
