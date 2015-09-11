
function obj = viewer_create_appearance(obj)
    %% obj = VIEWER_CREATE_APPEARANCE(obj)

    %% function
    disp('viewer_create_appearance');
    
    % appearance
    set(obj.fig.viewer.axis,'Visible','on');
    set(obj.fig.viewer.axis,'XTick',[]);
    set(obj.fig.viewer.axis,'YTick',[]);
    set(obj.fig.viewer.axis,'Box','on');
    set(obj.fig.viewer.axis,'XColor',[0,0,0]);
    set(obj.fig.viewer.axis,'YColor',[0,0,0]);

    % depending on the POV
    set(obj.fig.viewer.axis(1,:),'PlotBoxAspectRatio',[109,91,1]);
    set(obj.fig.viewer.axis(1,:),'XLim',[1,obj.dat.size(2)]);
    set(obj.fig.viewer.axis(1,:),'YLim',[1,obj.dat.size(3)]);
   
    set(obj.fig.viewer.axis(2,:),'PlotBoxAspectRatio',[91,91,1]);
    set(obj.fig.viewer.axis(2,:),'XLim',[1,obj.dat.size(1)]);
    set(obj.fig.viewer.axis(2,:),'YLim',[1,obj.dat.size(3)]);

    set(obj.fig.viewer.axis(3,:),'PlotBoxAspectRatio',[109,91,1]);
    set(obj.fig.viewer.axis(3,:),'XLim',[1,obj.dat.size(2)]);
    set(obj.fig.viewer.axis(3,:),'YLim',[1,obj.dat.size(1)]);
end
