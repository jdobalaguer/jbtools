
function obj = viewer_create_background(obj)
    %% obj = VIEWER_CREATE_BACKGROUND(obj)

    %% notes
    % matlab only allows one colormap per figure
    % hack - we display the background without the actual colormap (using @surface)
    
    %% function
    disp('viewer_create_background');
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % remove previous background/statistics
    delete(obj.fig.viewer.background);
    
    % print background/statistics
    obj.fig.viewer.background = repmat(matlab.graphics.chart.primitive.Surface,[3,n_file]); % create a surface matrix
    delete(obj.fig.viewer.background);
    for i_pov = 1:3
        for i_file = 1:n_file
            
            % display
            a = obj.fig.viewer.axis(i_pov,i_file);
            switch i_pov
                case 1
                    obj.fig.viewer.background(i_pov,i_file) = aux_db(obj,nan,a);
                case 2
                    obj.fig.viewer.background(i_pov,i_file) = aux_db(obj,nan,a);
                case 3
                    obj.fig.viewer.background(i_pov,i_file) = aux_db(obj,nan,a);
            end
        end
    end
end
