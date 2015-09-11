
function obj = scan_view(varargin)
    %% SCAN_VIEW(scan,file1,file2,..)
    % tool to visualize statistical maps
    % to list main functions, try
    %   >> help scan;
    
    %% function
    obj = new_parse(varargin{:});
    obj = new_parameters(obj);
    obj = new_load(obj);
    obj = new_figures(obj);
end
