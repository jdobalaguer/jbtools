
function z = struct_set(s,a,ii)
    %% z = STRUCT_SET(s,a,ii)
    % set fields from [a] inside the [ii] indices of the fields of [s]
    
    %% function
    assert(struct_cmp(s,a));
    u = fieldnames(s);
    n = length(u);
    z = s;
    for i = 1:n
        z.(u{i})(ii,:) = a.(u{i});
    end
end
