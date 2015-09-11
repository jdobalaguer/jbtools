
function obj = new_load(obj)
    %% obj = NEW_LOAD(obj)

    %% function
    disp('new_load');
    
    obj = new_load_volumes(obj);
    obj = new_load_template(obj);
end
