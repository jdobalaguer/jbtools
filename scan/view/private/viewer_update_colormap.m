
function obj = viewer_update_colormap(obj)
    %% obj = VIEWER_UPDATE_COLORMAP(obj)

    %% function
    disp('viewer_update_colormap');
    
    % tail
    if get(findobj(obj.fig.control.figure,'Tag','PositiveRadio'),'Value')
        cmap = fig_color(obj.par.viewer.colormap.positive, obj.par.viewer.colormap.resolution);
    elseif get(findobj(obj.fig.control.figure,'Tag','NegativeRadio'),'Value')
        cmap = fig_color(obj.par.viewer.colormap.negative, obj.par.viewer.colormap.resolution);
    else
        cmap = fig_color(obj.par.viewer.colormap.both,     obj.par.viewer.colormap.resolution);
    end
    
    % set colormap
    colormap(obj.fig.viewer.figure,cmap);
end
