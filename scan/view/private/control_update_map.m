
function obj = control_update_map(obj)
    %% obj = CONTROL_UPDATE_MAP(obj)
    % update the map popup
    
    %% function
    disp('control_update_map');
    
    % get selected files
    ii_file = control_get_file(obj);
    
    % get maps
    u_map = {obj.dat.statistics(ii_file).map};
    n_map = sum(ii_file);
    
    % assert
    switch n_map
        case 0, map = '';
        case 1, map = u_map{1};
        otherwise
            if isequal(u_map{:}), map = u_map{1};
            else                  map = ''; scan_tool_warning(obj.scan,false,'files have different statistics');
            end
    end
    
    % update
    h = obj.fig.control.figure;
    switch map
        case 'T',  set(findobj(h,'Tag','MapPopup'),'Value',1);
        case 'F',  set(findobj(h,'Tag','MapPopup'),'Value',2);
        case 'P',  set(findobj(h,'Tag','MapPopup'),'Value',3);
        otherwise, set(findobj(h,'Tag','MapPopup'),'Value',4);
    end
end
