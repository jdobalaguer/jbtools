function jbtools_status()
    %% JBTOOLS_STATUS()
    % git status from jbtools root folder

    %% warnings

    %% function
    curr = pwd();
    root = jbtools_root();
    
    cd(root);
    git('status');
    cd(curr);
end