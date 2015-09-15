
function obj = mask_default(obj)
    %% obj = MASK_DEFAULT(obj)

    %% function
    disp('mask_default');
    
    h = obj.fig.mask.figure;
    
    % figure
    set(h,'Visible',aux_bool2string(obj.par.control.windows.mask));
    
    % whatever
    % TODO

end
