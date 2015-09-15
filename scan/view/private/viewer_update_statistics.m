
function obj = viewer_update_statistics(obj)
    %% obj = VIEWER_UPDATE_STATISTICS(obj)

    %% notes
    % 1. what to show depends on the statistics (whether it's p-map in particular)
    
    %% function
    disp('viewer_update_statistics');
    
    % get number of files
    x_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    n_file = length(x_file);
    
    % coordinate
    x = str2double(get(findobj(obj.fig.control.figure,'Tag','XEdit'),'String'));
    y = str2double(get(findobj(obj.fig.control.figure,'Tag','YEdit'),'String'));
    z = str2double(get(findobj(obj.fig.control.figure,'Tag','ZEdit'),'String'));
    
    % update statistics
    for i_file = 1:n_file
        
        % box coordinates
        [xbox,ybox,zbox] = aux_getBox(obj.dat.statistics(x_file(i_file)));
        
        % load volume
        v_data   = obj.dat.statistics(x_file(i_file)).data;
        v_matrix = obj.dat.statistics(x_file(i_file)).matrix;
        v_size   = obj.dat.statistics(x_file(i_file)).size;

        % mask statistics
        img = nan(size(v_data));
        tmin = str2double(get(findobj(obj.fig.control.figure,'Tag','StatEdit'),'string'));
        if get(findobj(obj.fig.control.figure,'Tag','PositiveRadio'),'Value')
            img(v_data(:) >= +tmin) = v_data(v_data(:) >= +tmin);
        elseif get(findobj(obj.fig.control.figure,'Tag','NegativeRadio'),'Value')
            img(v_data(:) <= -tmin) = v_data(v_data(:) <= -tmin);
        elseif get(findobj(obj.fig.control.figure,'Tag','BothRadio'),'Value')
            img(v_data(:) >= +tmin) = v_data(v_data(:) >= +tmin);
            img(v_data(:) <= -tmin) = v_data(v_data(:) <= -tmin);
        else
            scan_tool_warning(obj.scan,false,'no tail selected');
        end
        v_data = img;

        % calculate the slice for the POV
        for i_pov = 1:3
            switch i_pov
                case 1
                    r  = [v_size(2),v_size(3)];
                    ux = linspace(ybox(1),ybox(2),r(1));
                    uy = linspace(zbox(1),zbox(2),r(2));
                    mni = aux_plane(x,ux,uy);
                    [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                    cdata = aux_slice(v_data,v_matrix,mni,r,'nearest');
                case 2
                    r  = [v_size(1),v_size(3)];
                    ux = linspace(xbox(1),xbox(2),r(1));
                    uy = linspace(zbox(1),zbox(2),r(2));
                    mni = aux_plane(ux,y,uy);
                    [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                    cdata = aux_slice(v_data,v_matrix,mni,r,'nearest');
                case 3
                    r  = [v_size(2),v_size(1)];
                    ux = linspace(ybox(1),ybox(2),r(1));
                    uy = linspace(xbox(1),xbox(2),r(2));
                    mni = aux_plane(uy,ux,z);
                    [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                    cdata = aux_slice(v_data,v_matrix,mni,fliplr(r),'nearest')';
            end
            
            % update
            set(obj.fig.viewer.statistics(i_pov,i_file),'XData',xdata,'YData',ydata,'ZData',zdata,'CData',cdata);
        end
    end
end
