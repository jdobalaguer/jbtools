
function obj = viewer_callback(obj)
    %% obj = VIEWER_CALLBACK(obj)

    %% function
    disp('viewer_callback');

    % figure
    set(obj.fig.viewer.figure,'CloseRequestFcn',@closeViewer);
    set(obj.fig.viewer.figure,'KeyPressFcn',    @keyViewer);
    
    %% nested functions
    function closeViewer(viewer,~),  obj = viewer_callback_close(obj,viewer); end
    function keyViewer(~,evt),       obj = viewer_callback_key(obj,evt);      end
end
