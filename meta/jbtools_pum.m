function jbtools_pum(varargin)
    %% JBTOOLS_PUM()
    % git pull, add, commit and push from jbtools root folder

    %% warnings

    %% function
    curr = pwd();
    root = jbtools_root();
    
    message = strcat(sprintf('%s ',varargin{:}));
    func_default('message','automatic upload');
    
    cd(root);
    git('pull');
    git('add -A');
    git('pum',message);
    cd(curr);
end