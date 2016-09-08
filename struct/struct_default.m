
function s = struct_default(o,t)
    %% s = STRUCT_DEFAULT(o,t)
    % complete template struct [t] with options struct [o] recursively
    % o : struct with input options
    % t : template with default values
    % s : resulting struct
    
    %% function
    s = recursive(o,t);
end

%% auxiliar
function s = recursive(o,t)
    s = t;
    u = fieldnames(o);
    for i = 1:length(u)
        f = u{i};
        if isstruct(o.(f)) && isfield(t,f) && isstruct(t.(f)) && isscalar(o.(f)) && isscalar(t.(f))
            s.(f) = recursive(o.(f),t.(f));
        else
            s.(f) = o.(f);
        end
    end
end
