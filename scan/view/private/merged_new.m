
function obj = merged_new(obj)
    %% obj = MERGED_NEW(obj)

    %% function
    disp('merged_new');
    
    % figure
    h = figure();
    set(h,'Name',           'Merged');
    set(h,'Tag',            'ControlFigure');
    set(h,'Units',          'pixels');
    set(h,'MenuBar',        'no');
    set(h,'Resize',         'off');
    set(h,'CloseRequestFcn',@closeMerged);
    if ~obj.par.control.windows.merged, set(h,'Visible','off'); end
    obj.fig.merged.figure = h;
    
    %% nested function
    function closeMerged(~,~)
        disp('close_merged');
        set(h,'Visible','off');
        check = findobj(obj.fig.control.figure,'Tag','MergedCheck');
        set(check,'Value',0);
    end
end
