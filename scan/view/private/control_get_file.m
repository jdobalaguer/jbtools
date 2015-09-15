
function ii_file = control_get_file(obj)
    %% ii_file = CONTROL_GET_FILE(obj)
    % get the selected file(s)
    
    %% function
    disp('control_get_file');
    
    file_list = findobj(obj.fig.control.figure,'Tag','FileList');
    ii_file = get(file_list,'Value');
end
