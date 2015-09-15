
function obj = viewer_create_statistics(obj)
    %% obj = VIEWER_CREATE_STATISTICS(obj)

    %% function
    disp('viewer_create_statistics');
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % remove previous background/statistics
    delete(obj.fig.viewer.statistics);
    
    % print background/statistics
    obj.fig.viewer.statistics = repmat(matlab.graphics.chart.primitive.Surface,[3,n_file]); % create a surface matrix
    delete(obj.fig.viewer.statistics);
    for i_pov = 1:3
        for i_file = 1:n_file
            
            % display
            a = obj.fig.viewer.axis(i_pov,i_file);
            switch i_pov
                case 1
                    obj.fig.viewer.statistics(i_pov,i_file) = aux_ds(obj,nan,a);
                case 2
                    obj.fig.viewer.statistics(i_pov,i_file) = aux_ds(obj,nan,a);
                case 3
                    obj.fig.viewer.statistics(i_pov,i_file) = aux_ds(obj,nan,a);
            end
        end
    end
    
    % colormap
    cmap = fig_color(obj.par.viewer.colormap.statistics, obj.par.viewer.colormap.resolution);
    colormap(obj.fig.viewer.figure,cmap);
end
