
function jbtools_rm()
    %% JBTOOLS_RM()

    %% warnings

    %% function
    dirs = jbtools_dirs();
    for i_dirs = 1:length(dirs)
        rmpath(genpath(dirs{i_dirs}));
    end
end