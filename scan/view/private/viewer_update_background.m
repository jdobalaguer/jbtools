
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
    bg_data   = obj.dat.background(ii_bg).data;
    
    % get statistics (needed for low resolution)
    ii_file = control_get_file(obj);
    ii_file = ii_file(1); % hack, let's use resolution of the first file
    
    % box coordinates
    [xbox,ybox,zbox] = aux_getBox(obj.dat.background(ii_bg));
    
    % resolution
    bgr_pop = findobj(obj.fig.control.figure,'Tag','BgResolutionPopup');
    u_resolution = get(bgr_pop,'String');
    i_resolution = get(bgr_pop,'Value');
    resolution   = u_resolution{i_resolution};
    method = 'linear';
    switch resolution
        case 'Low',
            method = 'nearest';
            lim_bg = mat2row(cellfun(@(x)diff(ranger(x)),(struct2cell(obj.dat.background(ii_bg).mni))));
            lim_st = mat2row(cellfun(@(x)diff(ranger(x)),(struct2cell(obj.dat.statistics(ii_file).mni))));
            siz_st = obj.dat.statistics(ii_file).size;
            bg_size = lim_bg .* siz_st ./ lim_st;
        case 'Med',  bg_size = 1.0 * obj.dat.background(ii_bg).size;
        case 'High', bg_size = 2.0 * obj.dat.background(ii_bg).size;
        otherwise,   bg_size = 1.0 * obj.dat.background(ii_bg).size;
    end
    
    % update background
    for i_pov = 1:3
        
        % calculate the slice for the POV
        switch i_pov
            case 1
                r  = round([bg_size(2),bg_size(3)]);
                ux = linspace(ybox(1),ybox(2),r(1));
                uy = linspace(zbox(1),zbox(2),r(2));
                mni = aux_plane(x,ux,uy);
                [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                cdata = aux_slice(bg_data,bg_matrix,mni,r,method);
            case 2
                r  = round([bg_size(1),bg_size(3)]);
                ux = linspace(xbox(1),xbox(2),r(1));
                uy = linspace(zbox(1),zbox(2),r(2));
                mni = aux_plane(ux,y,uy);
                [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                cdata = aux_slice(bg_data,bg_matrix,mni,r,method);
            case 3
                r  = round([bg_size(2),bg_size(1)]);
                ux = linspace(ybox(1),ybox(2),r(1));
                uy = linspace(xbox(1),xbox(2),r(2));
                mni = aux_plane(uy,ux,z);
                [xdata,ydata,zdata] = ndgrid(ux,uy,0);
                cdata = aux_slice(bg_data,bg_matrix,mni,fliplr(r),method)';
        end
        
        % center pixels and add a dummy last row/column
        [xdata,ydata,zdata,cdata] = aux_centerSurface(xdata,ydata,zdata,cdata);
        
        % set grayscale colour
        cdata = repmat(cdata,[1,1,3]);
        
        % update without transparency
        if isempty(obj.par.viewer.background.alpha),
            for i_file = 1:n_file
                set(obj.fig.viewer.background(i_pov,i_file),'XData',xdata,'YData',ydata,'ZData',zdata,'CData',cdata);
            end
            continue;
        end
            
        % update with transparency
        adata = (nan2zero(cdata(:,:,1)) - obj.par.viewer.background.alpha(1)) ./ diff(obj.par.viewer.background.alpha);
        adata(adata(:)<0) = 0;
        adata(adata(:)>1) = 1;
        for i_file = 1:n_file
            set(obj.fig.viewer.background(i_pov,i_file),'XData',xdata,'YData',ydata,'ZData',zdata,'CData',cdata,'AlphaData',adata,'FaceAlpha','flat');
        end
    end
end
