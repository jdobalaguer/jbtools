
function obj = viewer_default(obj)
    %% obj = VIEWER_DEFAULT(obj)

    %% function
    disp('viewer_default');
    
    h = obj.fig.viewer.figure;
    
    % figure
    set(h,'Visible',aux_bool2string(obj.par.control.windows.viewer));
end
