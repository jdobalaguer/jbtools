
function obj = viewer_create_axes(obj)
    %% obj = VIEWER_CREATE_AXES(obj)

    %% notes
    % 1. fawt force that the axis is actually for that figure (without calling the figure)
    % 2. new arrangement
    % 3. slices, buttons, labels
    % 4. see http://uk.mathworks.com/matlabcentral/newsreader/view_thread/246599

    
    %% function
    disp('viewer_create_axes');
    
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
