
function obj = atlas_default(obj)
    %% obj = ATLAS_DEFAULT(obj)

    %% function
    disp('atlas_default');
    
    h = obj.fig.atlas.figure;
    
    % figure
    set(h,'Visible',aux_bool2string(obj.par.control.windows.atlas));
    
    % whatever
    % TODO

end
