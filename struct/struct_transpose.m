function z = struct_transpose(s)
    %% z = STRUCT_TRANSPOSE(s)
    % transpose fields
    
    %% warnings
    
    %% function
    z = struct_fun(s,@transpose);
    
end