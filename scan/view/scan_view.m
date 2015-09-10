
function obj = scan_view(varargin)
    %% SCAN_VIEW
    % allows you to visualize t-maps etc..
    
    obj = new_parse(varargin{:});
    obj = new_load(obj);
    obj = new_parameters(obj);
    obj = new_figures(obj);
end
