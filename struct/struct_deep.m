
function z = struct_deep(s)
    %% z = STRUCT_DEEP(s)
    % transforms single (flat) struct into a hierarchical (deep) struct
    
    %% warnings
    
    %% function
    assert(isstruct(s), 'struct_deep: error. s not a struct');
    assert(isscalar(s), 'struct_deep: error. s not scalar');
    z = deepen(s);
end

function z = deepen(s)
    u = fieldnames(s);
    n = length(u);
    f = strrep(u,'_','.');
    
    z = struct();
    for i = 1:length(f)
        cmd = ['z.',f{i},' = s.',u{i},';'];
        eval(cmd);
    end
end