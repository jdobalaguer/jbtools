
function obj = viewer_update_appearance(obj)
    %% obj = VIEWER_UPDATE_APPEARANCE(obj)

    %% function
    disp('viewer_update_appearance');
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % appearance
    for i_pov = 1:3
        for i_file = 1:n_file
            set (obj.fig.viewer.axis(i_pov,i_file),'Visible','on');
            set (obj.fig.viewer.axis(i_pov,i_file),'XTick',[]);
            set (obj.fig.viewer.axis(i_pov,i_file),'YTick',[]);
            set (obj.fig.viewer.axis(i_pov,i_file),'Box','on');
            set (obj.fig.viewer.axis(i_pov,i_file),'XColor',[0,0,0]);
            set (obj.fig.viewer.axis(i_pov,i_file),'YColor',[0,0,0]);
            switch i_pov
                case 1 
                    set(obj.fig.viewer.axis(i_pov,i_file),'PlotBoxAspectRatio',[109,91,1]);
                    set(obj.fig.viewer.axis(i_pov,i_file),'XLim',[1,obj.dat.size(2)]);
                    set(obj.fig.viewer.axis(i_pov,i_file),'YLim',[1,obj.dat.size(3)]);
                case 2
                    set(obj.fig.viewer.axis(i_pov,i_file),'PlotBoxAspectRatio',[91,91,1]);
                    set(obj.fig.viewer.axis(i_pov,i_file),'XLim',[1,obj.dat.size(1)]);
                    set(obj.fig.viewer.axis(i_pov,i_file),'YLim',[1,obj.dat.size(3)]);
                case 3
                    set(obj.fig.viewer.axis(i_pov,i_file),'PlotBoxAspectRatio',[109,91,1]);
                    set(obj.fig.viewer.axis(i_pov,i_file),'XLim',[1,obj.dat.size(2)]);
                    set(obj.fig.viewer.axis(i_pov,i_file),'YLim',[1,obj.dat.size(1)]);
            end
        end
    end
end
