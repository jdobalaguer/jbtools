
function obj = viewer_default(obj)
    %% obj = VIEWER_DEFAULT(obj)

    %% function
    disp('viewer_default');
    
    h = obj.fig.viewer.figure;
    
    % figure
    set(h,'Visible',bool2string(obj.par.control.windows.viewer));
    
    % axis
    obj.fig.viewer.axis = repmat(matlab.graphics.axis.Axes,[3,length(obj.par.control.windows.selected)]);
    
    % whatever
    % TODO

end

function s = bool2string(b)
    s = 'off';
    if b, s = 'on'; end
end
