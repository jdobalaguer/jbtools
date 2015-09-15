
function obj = glass_default(obj)
    %% obj = GLASS_DEFAULT(obj)

    %% function
    disp('glass_default');
    
    h = obj.fig.glass.figure;
    
    % figure
    set(h,'Visible',aux_bool2string(obj.par.control.windows.glass));
    
    % whatever
    % TODO

end
