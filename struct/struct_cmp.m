
function b = struct_cmp(s1,s2)
    %% b = STRUCT_CMP(s1,s2)
    % compare the fields between two structures
    
    %% warnings
    
    %% function
    u1 = fieldnames(s1);
    u2 = fieldnames(s2);
    n1 = length(u1);
    n2 = length(u2);
    b  = (n1==n2) && all(strcmp(u1,u2));

end