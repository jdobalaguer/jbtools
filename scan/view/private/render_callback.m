
function obj = render_callback(obj)
    %% obj = GLASS_CALLBACK(obj)

    %% function
    disp('render_callback');

    % figure
    set(obj.fig.render.figure,'CloseRequestFcn',@closeRender);
    
    %% nested functions
    function closeRender(render,~),  obj = render_callback_close(obj,render); end
end
