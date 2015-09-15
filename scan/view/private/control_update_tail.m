
function obj = control_update_tail(obj,radio)
    %% obj = CONTROL_UPDATE_TAIL(obj,edit)
    
    %% function
    disp('control_update_tail');
    
    % handles
    h = obj.fig.control.figure;
    p_radio  = findobj(obj.fig.control.figure,'Tag','PositiveRadio');
    n_radio  = findobj(obj.fig.control.figure,'Tag','NegativeRadio');
    b_radio  = findobj(obj.fig.control.figure,'Tag','BothRadio');
    
    % tail
    set(p_radio,'Value',0);
    set(n_radio,'Value',0);
    set(b_radio,'Value',0);
    if ~isempty(radio), set(radio,'Value',1);
    else
        % none selected, default
        switch obj.par.control.statistics.tail
            case 'Positive', set(p_radio,'Value',1);
            case 'Negative', set(n_radio,'Value',1);
            case 'Both',     set(b_radio,'Value',1);
        end
    end
end
