
function obj = control_load(obj)
    %% obj = CONTROL_LOAD(obj)

    %% function
    disp('control_load');
    
    obj = control_load_statistics(obj);
    obj = control_load_background(obj);
end
