
function z = struct_transpose(s)
    %% z = STRUCT_TRANSPOSE(s)
    % transpose fields
    
    %% function
    z = struct_fun(s,@transpose);
end
