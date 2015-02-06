function jbtools_pull()
    %% JBTOOLS_PULL()
    % git pull from jbtools root folder

    %% warnings

    %% function
    curr = pwd();
    root = jbtools_root();
    
    cd(root);
    git('pull');
    cd(curr);
end