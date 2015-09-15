
function obj = glass_callback(obj)
    %% obj = GLASS_CALLBACK(obj)

    %% function
    disp('glass_callback');

    % figure
    set(obj.fig.glass.figure,'CloseRequestFcn',@closeGlass);
    
    %% nested functions
    function closeGlass(glass,~),  obj = glass_callback_close(obj,glass); end
end
