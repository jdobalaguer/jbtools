
function z = struct_flat(s)
    %% z = STRUCT_FLAT(s)
    % transforms hierarchical (deep) struct into a single (flat) struct
    
    %% warnings
    
    %% function
    
    assert(isstruct(s), 'struct_flat: error. s not a struct');
    assert(isscalar(s), 'struct_flat: error. s not scalar');
    z = flatten(s);
end


function z = flatten(s1)
    u1 = fieldnames(s1);
    n1 = length(u1);
    
    z = struct();
    for i1 = 1:n1
        f1 = u1{i1};
        s2 = s1.(f1);
        if isstruct(s2)
            s2 = flatten(s2);
            u2 = fieldnames(s2);
            n2 = length(u2);
            for i2 = 1:n2
                f2 = u2{i2};
                z.([f1,'_',f2]) = s2.(f2);
            end
        else
            z.(f1) = s2;
        end
    end
end
