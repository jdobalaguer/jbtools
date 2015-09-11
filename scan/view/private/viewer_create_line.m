
function obj = viewer_create_line(obj)
    %% obj = VIEWER_CREATE_LINE(obj)

    %% function
    disp('viewer_create_line');
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % coordinate
    x = str2double(get(findobj(obj.fig.control.figure,'Tag','XEdit'),'String'));
    y = str2double(get(findobj(obj.fig.control.figure,'Tag','YEdit'),'String'));
    z = str2double(get(findobj(obj.fig.control.figure,'Tag','ZEdit'),'String'));
    
    % remove previous lines
    delete(vec_filter(@ishandle,obj.fig.viewer.line.x));
    delete(vec_filter(@ishandle,obj.fig.viewer.line.y));
    
    % print background
    obj.fig.viewer.line.x = nan(3,n_file);
    obj.fig.viewer.line.y = nan(3,n_file);
    for i_pov = 1:3
        for i_file = 1:n_file
            
            % axis and colour
            a = obj.fig.viewer.axis(i_pov,i_file);
            c = obj.par.viewer.line.color;
            
            % create lines
            switch i_pov
                case 1
                    obj.fig.viewer.line.x(i_pov,i_file) = line([1,obj.dat.size(2)],[z,z],'Color',c,'Parent',a);
                    obj.fig.viewer.line.y(i_pov,i_file) = line([y,y],[1,obj.dat.size(3)],'Color',c,'Parent',a);
                case 2
                    obj.fig.viewer.line.x(i_pov,i_file) = line([1,obj.dat.size(1)],[z,z],'Color',c,'Parent',a);
                    obj.fig.viewer.line.y(i_pov,i_file) = line([x,x],[1,obj.dat.size(3)],'Color',c,'Parent',a);
                case 3
                    obj.fig.viewer.line.x(i_pov,i_file) = line([1,obj.dat.size(2)],[x,x],'Color',c,'Parent',a);
                    obj.fig.viewer.line.y(i_pov,i_file) = line([y,y],[1,obj.dat.size(1)],'Color',c,'Parent',a);
            end
        end
    end
end
