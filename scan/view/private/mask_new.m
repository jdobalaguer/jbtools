
function obj = mask_new(obj)
    %% obj = MASK_NEW(obj)

    %% function
    disp('mask_new');
    
    % figure
    h = figure();
    set(h,'Name',           'Mask Manager');
    set(h,'Tag',            'ControlFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'off');
    set(h,'CloseRequestFcn',@closeMask);
    if ~obj.par.control.windows.mask, set(h,'Visible','off'); end
    obj.fig.mask.figure = h;
    
    %% nested function
    function closeMask(~,~)
        disp('close_mask');
        set(h,'Visible','off');
        check = findobj(obj.fig.control.figure,'Tag','MaskCheck');
        set(check,'Value',0);
    end
end
