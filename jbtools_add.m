
function jbtools_add()
    %% JBTOOLS_ADD()

    %% warnings

    %% function
    dirs = jbtools_dirs();
    for i_dirs = 1:length(dirs)
        addpath(genpath(dirs{i_dirs}));
    end
end