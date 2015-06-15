
function z = struct_func(s,f)
    %% z = STRUCT_FUNC(s,f)
    % s : struct
    % f : function

    %% function
    u_field = fieldnames(s);
    n_field = length(u_field);
    z = struct();
    for i_field = 1:n_field
        field = u_field{i_field};
        z.(field) = f(s.(field));
    end
end
