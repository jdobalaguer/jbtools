function s = struct_filter(s,ii)
    %% s = STRUCT_FILTER(s,ii)
    
    %% warnings
    
    %% function
    u_field = fieldnames(s);
    n_field = length(u_field);
    for i_field = 1:n_field
        field = u_field{i_field};
        s.(field) = s.(field)(ii,:);
    end
    
end