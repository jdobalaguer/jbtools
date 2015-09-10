
function obj = viewer_update_line(obj)
    %% obj = VIEWER_UPDATE_line(obj)

    %% function
    disp('viewer_update_line');
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % coordinate
    x = str2double(get(findobj(obj.fig.control.figure,'Tag','XEdit'),'String'));
    y = str2double(get(findobj(obj.fig.control.figure,'Tag','YEdit'),'String'));
    z = str2double(get(findobj(obj.fig.control.figure,'Tag','ZEdit'),'String'));
    
    % print background
    for i_pov = 1:3
        for i_file = 1:n_file
            axes(obj.fig.viewer.axis(i_pov,i_file)); %#ok<LAXES>
            switch i_pov
                case 1
                    line([1,obj.dat.size(2)],[z,z],'Color',[1,1,1])
                    line([y,y],[1,obj.dat.size(3)],'Color',[1,1,1])
                case 2
                    line([1,obj.dat.size(1)],[z,z],'Color',[1,1,1])
                    line([x,x],[1,obj.dat.size(3)],'Color',[1,1,1])
                case 3
                    line([1,obj.dat.size(2)],[x,x],'Color',[1,1,1])
                    line([y,y],[1,obj.dat.size(1)],'Color',[1,1,1])
            end
        end
    end
end
