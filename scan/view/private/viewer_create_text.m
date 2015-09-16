
function obj = viewer_create_text(obj)
    %% obj = VIEWER_CREATE_TEXT(obj)

    %% function
    disp('viewer_create_text');
    
    % remove previous axes
    delete(obj.fig.viewer.text.pvalue);
    delete(obj.fig.viewer.text.statistic);
    
    % get number of files
    u_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    n_file = length(u_file);
    
    % create new axes
    obj.fig.viewer.text.pvalue    = repmat(matlab.graphics.primitive.Text,[1,n_file]); % create a text vector
    obj.fig.viewer.text.statistic = repmat(matlab.graphics.primitive.Text,[1,n_file]); % create a text vector
    delete(obj.fig.viewer.text.pvalue);
    delete(obj.fig.viewer.text.statistic);
    for i_file = 1:n_file
        obj.fig.viewer.text.pvalue(i_file) = text(0,130,1,'p = 0.0000',...
                                             'Parent',obj.fig.viewer.axis(3,i_file),...
                                             'Color',obj.par.viewer.text.color,...
                                             'FontSize',obj.par.viewer.text.size,...
                                             'HorizontalAlignment','center');
        obj.fig.viewer.text.statistic(i_file) = text(0,170,1,'n = +0.00',...
                                             'Parent',obj.fig.viewer.axis(3,i_file),...
                                             'Color',obj.par.viewer.text.color,...
                                             'FontSize',obj.par.viewer.text.size,...
                                             'HorizontalAlignment','center');
    end
end
