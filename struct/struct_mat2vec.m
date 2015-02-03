function z = struct_mat2vec(s)
    %% z = STRUCT_MAT2VEC(s)
    % transpose fields
    
    %% warnings
    
    %% function
    z = struct_fun(s,@mat2vec);
    
end