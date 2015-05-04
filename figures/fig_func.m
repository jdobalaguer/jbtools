
function fig_func(f,h)
    %% FIG_FUNC
    % run a function recursively across all (sub)children of a figure
    
    %% warnings
    %#ok<*LAXES>
    
    %% function
    default('h',gcf());
    recursive_function(f,h);
end

%% auxiliar
function recursive_function(f,h)
    c = allchild(h);
    for i = 1:length(c)
        recursive_function(c(i));
        f(h);
    end
end
