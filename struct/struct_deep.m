
function z = struct_deep(s)
    %% z = STRUCT_DEEP(s)
    % transforms single (flat) struct into a hierarchical (deep) struct
    
    %% warnings
    %#ok<*AGROW>
    
    %% function
    assertStruct(s);
    assertVector(s);
    for i = 1:length(s)
        z(i) = deepen(s(i));
    end
end

%% auxiliar
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
