
function obj = viewer_callback_tail(obj,tail)
    %% obj = VIEWER_CALLBACK_TAIL(obj,tail)
    
    %% function
    disp('viewer_callback_tail');
    
    switch tail
        case 'p'
            set(findobj(obj.fig.control.figure,'Tag','PositiveRadio'),'Value',1);
            set(findobj(obj.fig.control.figure,'Tag','NegativeRadio'),'Value',0);
            set(findobj(obj.fig.control.figure,'Tag','BothRadio'),    'Value',0);
        case 'n'
            set(findobj(obj.fig.control.figure,'Tag','PositiveRadio'),'Value',0);
            set(findobj(obj.fig.control.figure,'Tag','NegativeRadio'),'Value',1);
            set(findobj(obj.fig.control.figure,'Tag','BothRadio'),    'Value',0);
        case 'b'
            set(findobj(obj.fig.control.figure,'Tag','PositiveRadio'),'Value',0);
            set(findobj(obj.fig.control.figure,'Tag','NegativeRadio'),'Value',0);
            set(findobj(obj.fig.control.figure,'Tag','BothRadio'),    'Value',1);
        otherwise
            return;
    end
    
    % update other figures
    obj = control_update_statistics(obj);
    obj = viewer_update_statistics(obj);
    obj = viewer_update_Clim(obj);
    obj = viewer_update_colormap(obj);
end

