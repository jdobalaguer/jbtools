
function obj = new_parameters(obj)
    %% obj = NEW_PARAMETERS(obj)

    %% function
    disp('new_parameters');
    obj.par = struct();

    % control
    obj.par.control.windows.viewer      = true;
    obj.par.control.windows.glass       = false;
    obj.par.control.windows.mask        = false;
    obj.par.control.windows.atlas       = false;
    obj.par.control.windows.merged      = false;
    
    obj.par.control.windows.selected    = 1; %1:obj.dat.number;
    
    obj.par.control.statistics.tail     = 'Both';
    obj.par.control.statistics.pvalue   = 0.001;
    
    obj.par.control.position.x          = 21;
    obj.par.control.position.y          = 24;
    obj.par.control.position.z          = 20;
    
    % viewer
    obj.par.viewer.line.color           = [1,1,1];
    obj.par.viewer.colormap.statistics  = 'jet';
    obj.par.viewer.colormap.resolution  = 64;
    
end
