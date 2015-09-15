
function obj = viewer_update_XYlim(obj)
    %% obj = VIEWER_UPDATE_XYLIM(obj)
    % update the limits of the figure
    
    %% function
    ii_file = control_get_file(obj);
    ii_bg   = control_get_background(obj);
    
    % concatenate MNI
    mni = cat(1,obj.dat.statistics(ii_file).mni,obj.dat.background(ii_bg).mni);
    x_min = min(arrayfun(@(mni)min(mni.x(:)),mni)) - obj.par.viewer.marge;
    x_max = max(arrayfun(@(mni)max(mni.x(:)),mni)) + obj.par.viewer.marge;
    x_dif = x_max - x_min;
    y_min = min(arrayfun(@(mni)min(mni.y(:)),mni)) - obj.par.viewer.marge;
    y_max = max(arrayfun(@(mni)max(mni.y(:)),mni)) + obj.par.viewer.marge;
    y_dif = y_max - y_min;
    z_min = min(arrayfun(@(mni)min(mni.z(:)),mni)) - obj.par.viewer.marge;
    z_max = max(arrayfun(@(mni)max(mni.z(:)),mni)) + obj.par.viewer.marge;
    z_dif = z_max - z_min;
    
    % x axis
    set(obj.fig.viewer.axis(1,:),'PlotBoxAspectRatio',[y_dif,z_dif,1]);
    set(obj.fig.viewer.axis(1,:),'XLim',[y_min,y_max]);
    set(obj.fig.viewer.axis(1,:),'YLim',[z_min,z_max]);
   
    % y axis
    set(obj.fig.viewer.axis(2,:),'PlotBoxAspectRatio',[x_dif,z_dif,1]);
    set(obj.fig.viewer.axis(2,:),'XLim',[x_min,x_max]);
    set(obj.fig.viewer.axis(2,:),'YLim',[z_min,z_max]);

    % z axis
    set(obj.fig.viewer.axis(3,:),'PlotBoxAspectRatio',[y_dif,x_dif,1]);
    set(obj.fig.viewer.axis(3,:),'XLim',[y_min,y_max]);
    set(obj.fig.viewer.axis(3,:),'YLim',[x_min,x_max]);
end
