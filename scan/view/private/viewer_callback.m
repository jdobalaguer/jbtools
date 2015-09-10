
function obj = viewer_callback(obj)
    %% obj = VIEWER_CALLBACK(obj)

    %% function
    disp('viewer_callback');

    % figure
    set(obj.fig.viewer.figure,'CloseRequestFcn',@closeViewer);
    
    %% nested functions
    
    % control
    function closeViewer(viewer,~)
        disp('close_viewer');
        set(viewer,'Visible','off');
        check = findobj(obj.fig.control.figure,'Tag','ViewerCheck');
        set(check,'Value',0);
    end
end
