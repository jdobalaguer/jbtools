
function b = struct_cmp(s1,s2,depth)
    %% b = STRUCT_CMP(s1,s2)
    % compare the fields between two structures
    
    %% function
    func_default('depth',false);
    if depth
        s1 = struct_flat(s1);
        s2 = struct_flat(s2);
    end
    u1 = fieldnames(s1);
    u2 = fieldnames(s2);
    n1 = length(u1);
    n2 = length(u2);
    b  = (n1==n2) && all(strcmp(u1,u2));
end
