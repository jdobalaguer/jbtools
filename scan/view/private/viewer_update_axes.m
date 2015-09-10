
function obj = viewer_update_axes(obj)
    %% obj = VIEWER_UPDATE_AXES(obj)

    %% function
    disp('viewer_update_axes');
    
    % remove previous axes
    delete(obj.fig.viewer.axis);
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % create new axes
    figure(obj.fig.viewer.figure);
    obj.fig.viewer.axis = repmat(matlab.graphics.axis.Axes,[3,n_file]);
    j_axis = 0;
    for i_pov = 1:3
        for i_file = 1:n_file
            j_axis = j_axis + 1;
            obj.fig.viewer.axis(i_pov,i_file) = subplot(3,n_file,j_axis);
        end
    end
end
