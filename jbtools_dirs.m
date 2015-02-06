
function dirs = jbtools_dirs()
    %% dirs = JBTOOLS_DIRS()
    % returns the sub-directories in jbtools

    %% warnings

    %% function
    root = jbtools_root();
    dirs = dir(root);
    dirs = {dirs.name};
    for i_dirs = length(dirs):-1:1
        if any(dirs{i_dirs}=='.')
            dirs(i_dirs) = [];
        elseif isdir([root,filesep,dirs{i_dirs}])
            dirs{i_dirs} = [root,filesep,dirs{i_dirs}];
        end
    end
end