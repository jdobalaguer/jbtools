
function root = jbtools_root()
    %% root = JBTOOLS_ROOT()
    % returns the root path of jbtools

    %% warnings

    %% function
    root = fileparts(which('jbtools_root.m'));
end