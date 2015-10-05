
function obj = control_new(obj)
    %% obj = CONTROL_NEW(obj)

    %% function
    disp('control_new');
    
    % figure
    h = openfig(fullfile(file_parts(which('scan_view')),'private','figures','control.fig'));
    set(h,'Name',           'scan_view');
    set(h,'Tag',            'ControlFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'off');
    obj.fig.control.figure = h;
end
