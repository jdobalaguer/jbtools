function z = struct_fun(s,f)
    %% z = STRUCT_FUN(s,f)

    %% warnings
    
    %% function
    u_field = fieldnames(s);
    n_field = length(u_field);
    for i_field = 1:n_field
        field = u_field{i_field};
        z.(field) = f(s.(field));
    end
    
end