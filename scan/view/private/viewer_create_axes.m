
function obj = viewer_create_axes(obj)
    %% obj = VIEWER_CREATE_AXES(obj)

    %% notes
    % 1. new arrangement
    % 2. slices, buttons, labels
    % 3. see http://uk.mathworks.com/matlabcentral/newsreader/view_thread/246599

    
    %% function
    disp('viewer_create_axes');
    
    % remove previous axes
    delete(obj.fig.viewer.axis);
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % create new axes
    obj.fig.viewer.axis = repmat(matlab.graphics.axis.Axes,[3,n_file]); % create an axes matrix
    delete(obj.fig.viewer.axis);
    j_axis = 0;
    for i_pov = 1:3
        for i_file = 1:n_file
            j_axis = j_axis + 1;
            obj.fig.viewer.axis(i_pov,i_file) = subplot(3,n_file,j_axis,'Color',[0,0,0],'Parent',obj.fig.viewer.figure);
            %colorbar('peer',obj.fig.viewer.axis(i_pov,i_file));
        end
    end
    set(obj.fig.viewer.axis(3,:),'YDir','reverse');
end
