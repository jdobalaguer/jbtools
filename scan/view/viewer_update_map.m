
function obj = viewer_update_map(obj)
    %% obj = VIEWER_UPDATE_MAP(obj)

    %% notes
    % matlab only allows one colormap per figure
    % the hack here is that the display the background without the actual colormap
    
    %% function
    disp('viewer_update_map');
    
    % get number of files
    x_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    n_file = length(x_file);
    
    % coordinate
    x = str2double(get(findobj(obj.fig.control.figure,'Tag','XEdit'),'String'));
    y = str2double(get(findobj(obj.fig.control.figure,'Tag','YEdit'),'String'));
    z = str2double(get(findobj(obj.fig.control.figure,'Tag','ZEdit'),'String'));
    
    % template
    template = get(findobj(obj.fig.control.figure,'Tag','BackgroundPopup'),'Value');
    template = obj.dat.templates(template).volume;
    
    % print background
    obj.fig.viewer.background = repmat(matlab.graphics.chart.primitive.Surface,[3,n_file]);
    obj.fig.viewer.statistics = repmat(matlab.graphics.chart.primitive.Surface,[3,n_file]);
    for i_pov = 1:3
        for i_file = 1:n_file
            
            % load volume
            vol = obj.dat.volumes{x_file(i_file)};
            
            % mask statistics
            img = nan(size(vol));
            tmin = str2double(get(findobj(obj.fig.control.figure,'Tag','StatEdit'),'string'));
            img(vol(:) < -tmin) = vol(vol(:) < -tmin);
            img(vol(:) > +tmin) = vol(vol(:) > +tmin) + 1;
            
            % display
            axes(obj.fig.viewer.axis(i_pov,i_file)); %#ok<LAXES>
            hold('on');
            switch i_pov
                case 1
                    obj.fig.viewer.background(i_pov,i_file) = dispBg(obj,squeeze(template(x,:,:))');
                    obj.fig.viewer.statistics(i_pov,i_file) = fig_pimage(squeeze(img(x,:,:))');
                case 2
                    obj.fig.viewer.background(i_pov,i_file) = dispBg(obj,squeeze(template(:,y,:))');
                    obj.fig.viewer.statistics(i_pov,i_file) = fig_pimage(squeeze(img(:,y,:))');
                case 3
                    obj.fig.viewer.background(i_pov,i_file) = dispBg(obj,squeeze(template(:,:,z)));
                    obj.fig.viewer.statistics(i_pov,i_file) = fig_pimage(squeeze(img(:,:,z)));
            end
        end
    end
    
    % colormap
    cmap = fig_color(obj.par.viewer.colormap.statistics, obj.par.viewer.colormap.resolution);
    colormap(obj.fig.viewer.figure,cmap);
end

%% auxiliar
function h = dispBg(obj,slice)
    % DISPBG(obj,m)
    % display the background (ignoring the colormap)
    
    % grid
    z = zeros(mat_size(slice,[1,2]));
    c = repmat(slice,[1,1,3]);
    scan_tool_warning(obj.dat.scan,false,'ignoring the background colormap');
    
    % plot
    h = surface(z,c,'LineStyle','none','EdgeColor','none');
end