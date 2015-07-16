
function b = jbtools_added()
    %% root = JBTOOLS_ADDED()
    % is jbtools added?

    %% warnings

    %% function
    b = ~isempty(which('jbtools_rm.m'));
end
