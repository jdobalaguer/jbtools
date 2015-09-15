
function jbtools_finder()
    %% JBTOOLS_FINDER()
    % open a finder in the jbtools root folder

    %% warnings

    %% function
    curr = jbtools_root();
    eval(sprintf('!open %s',curr));
end