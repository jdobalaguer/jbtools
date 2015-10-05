
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
    obj.par.control.windows.render      = false;
    
    obj.par.control.file.selected       = 1;
    
    obj.par.control.statistics.tail     = 'Both';
    obj.par.control.statistics.stat     = nan;
    obj.par.control.statistics.pvalue   = 0.001;
    obj.par.control.statistics.fdr      = nan;
    
    obj.par.control.position.x          = 0;
    obj.par.control.position.y          = 0;
    obj.par.control.position.z          = 0;
    
    obj.par.control.background.name        = 'st1';
    obj.par.control.background.resolution  = 'Med';
    
    % viewer
    obj.par.viewer.marge                = 5;
    obj.par.viewer.color                = [0,0,0]; %[1,1,1];
    obj.par.viewer.text.color           = [1,1,1]; %[0,0,0];
    obj.par.viewer.text.size            = 14;
    obj.par.viewer.line.color           = [1,1,1,0.5];
    obj.par.viewer.line.thickness       = 1;
    obj.par.viewer.background.alpha     = []; %[0,0.1];
    obj.par.viewer.colormap.positive    = 'jet_positive';
    obj.par.viewer.colormap.negative    = 'jet_negative';
    obj.par.viewer.colormap.both        = 'jet';
    obj.par.viewer.colormap.resolution  = 64;
end
