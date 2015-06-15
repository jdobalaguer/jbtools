
function s = struct_add(s,a)
    %% s = STRUCT_ADD(s,a)
    % add fields from [a] to [s]
    % (this is a simpler version of @struct_default)
    
    %% function
    u = fieldnames(a);
    n = length(u);
    for i = 1:n
        s.(u{i}) =  a.(u{i});
    end
end
