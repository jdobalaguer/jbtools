

classdef scan_view_obj < handle
    %% obj = SCAN_VIEW_OBJ()
    % this is a (handle) class that allows shared information across @scan_view functions
    % to list main functions, try
    %   >> help scan;
    
    %% properties
    properties
        scan % scan
        dat  % data
        par  % parameter
        fig  % figure
    end
end
