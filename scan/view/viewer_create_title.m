
function obj = viewer_create_title(obj)
    %% obj = VIEWER_CREATE_TITLE(obj)

    %% function
    disp('viewer_create_title');
    
    % remove previous axes
    delete(obj.fig.viewer.title);
    
    % get number of files
    x_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'String');
    u_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    n_file = length(u_file);
    
    % create new axes
    obj.fig.viewer.title = repmat(matlab.graphics.primitive.Text,[1,n_file]); % create an axes matrix
    delete(obj.fig.viewer.title);
    for i_file = 1:n_file
        file = x_file{u_file(i_file)};
        file = strrep(file,'_',' ');
        file = strrep(file,'^',' ');
        obj.fig.viewer.title(i_file) = title(obj.fig.viewer.axis(1,i_file),file,...
                                             'Color',obj.par.viewer.title.color,...
                                             'FontSize',obj.par.viewer.title.size);
    end
end
