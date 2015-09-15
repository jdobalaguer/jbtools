
function obj = render_default(obj)
    %% obj = RENDER_DEFAULT(obj)

    %% function
    disp('render_default');
    
    h = obj.fig.render.figure;
    
    % figure
    set(h,'Visible',aux_bool2string(obj.par.control.windows.render));
    
    % whatever
    % TODO

end
