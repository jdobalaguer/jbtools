function jbtools_pum(message)
    %% JBTOOLS_PUM()
    % git pull, add, commit and push from jbtools root folder

    %% warnings

    %% function
    curr = pwd();
    root = jbtools_root();
    
    func_default('message','automatic upload');
    
    cd(root);
    git('pull');
    git('add -A');
    git('pum',message);
    cd(curr);
end