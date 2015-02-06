function jbtools_pum()
    %% JBTOOLS_PUM()
    % git pull, add, commit and push from jbtools root folder

    %% warnings

    %% function
    curr = pwd();
    root = jbtools_root();
    
    cd(root);
    git('pull');
    git('add -A');
    git('pum');
    cd(curr);
end