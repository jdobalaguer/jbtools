
function destructor(obj,~)
    %% DESTRUCTOR(obj)
    
    %% function
    disp('destructor');
    delete(obj.fig.control.figure);
    delete(obj.fig.viewer.figure);
    delete(obj.fig.glass.figure);
    delete(obj.fig.mask.figure);
    delete(obj.fig.atlas.figure);
    delete(obj.fig.merged.figure);
    delete(obj);
end
