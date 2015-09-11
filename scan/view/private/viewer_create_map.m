
function obj = viewer_create_map(obj)
    %% obj = VIEWER_CREATE_MAP(obj)

    %% notes
    % matlab only allows one colormap per figure
    % hack - we display the background without the actual colormap (using @surface)
    
    %% function
    disp('viewer_create_map');
    
    % get number of files
    x_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    n_file = length(x_file);
    
    % remove previous background/statistics
    delete(obj.fig.viewer.background);
    delete(obj.fig.viewer.statistics);
    
    % print background/statistics
    obj.fig.viewer.background = repmat(matlab.graphics.chart.primitive.Surface,[3,n_file]);
    obj.fig.viewer.statistics = repmat(matlab.graphics.chart.primitive.Surface,[3,n_file]);
    for i_pov = 1:3
        for i_file = 1:n_file
            
            % display
            a = obj.fig.viewer.axis(i_pov,i_file);
            switch i_pov
                case 1
                    obj.fig.viewer.background(i_pov,i_file) = aux_db(obj,zeros(obj.dat.size([3,2])),a);
                    obj.fig.viewer.statistics(i_pov,i_file) = aux_ds(obj,zeros(obj.dat.size([3,2])),a);
                case 2
                    obj.fig.viewer.background(i_pov,i_file) = aux_db(obj,zeros(obj.dat.size([3,1])),a);
                    obj.fig.viewer.statistics(i_pov,i_file) = aux_ds(obj,zeros(obj.dat.size([3,1])),a);
                case 3
                    obj.fig.viewer.background(i_pov,i_file) = aux_db(obj,zeros(obj.dat.size([1,2])),a);
                    obj.fig.viewer.statistics(i_pov,i_file) = aux_ds(obj,zeros(obj.dat.size([1,2])),a);
            end
        end
    end
    
    % colormap
    cmap = fig_color(obj.par.viewer.colormap.statistics, obj.par.viewer.colormap.resolution);
    colormap(obj.fig.viewer.figure,cmap);
end
