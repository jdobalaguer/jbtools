
function obj = viewer_update_background(obj)
    %% obj = VIEWER_UPDATE_BACKGROUND(obj)

    %% function
    disp('viewer_update_background');
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % coordinate
    x = str2double(get(findobj(obj.fig.control.figure,'Tag','XEdit'),'String'));
    y = str2double(get(findobj(obj.fig.control.figure,'Tag','YEdit'),'String'));
    z = str2double(get(findobj(obj.fig.control.figure,'Tag','ZEdit'),'String'));
    
    % get background
    ii_bg  = control_get_background(obj);
    bg_matrix = obj.dat.background(ii_bg).matrix;
    bg_size   = obj.dat.background(ii_bg).size;
    bg_data   = obj.dat.background(ii_bg).data;
    
    % box coordinates
    [xbox,ybox,zbox] = aux_getBox(obj.dat.background(ii_bg));
        
    % update background
    for i_pov = 1:3
        
        % calculate the slice for the POV
        switch i_pov
            case 1
                r  = [bg_size(2),bg_size(3)];
                ux = linspace(ybox(1),ybox(2),r(1));
                uy = linspace(zbox(1),zbox(2),r(2));
                mni = aux_plane(x,ux,uy);
                [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                cdata = aux_slice(bg_data,bg_matrix,mni,r,'linear');
            case 2
                r  = [bg_size(1),bg_size(3)];
                ux = linspace(xbox(1),xbox(2),r(1));
                uy = linspace(zbox(1),zbox(2),r(2));
                mni = aux_plane(ux,y,uy);
                [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                cdata = aux_slice(bg_data,bg_matrix,mni,r,'linear');
            case 3
                r  = [bg_size(2),bg_size(1)];
                ux = linspace(ybox(1),ybox(2),r(1));
                uy = linspace(xbox(1),xbox(2),r(2));
                mni = aux_plane(uy,ux,z);
                [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                cdata = aux_slice(bg_data,bg_matrix,mni,fliplr(r),'linear')';
        end
        
        % set grayscale colour
        cdata = repmat(cdata,[1,1,3]);
        
        % update
        for i_file = 1:n_file
            set(obj.fig.viewer.background(i_pov,i_file),'XData',xdata,'YData',ydata,'ZData',zdata,'CData',cdata);
        end
    end
end
