
function with_finder(filewith)
    %% WITH_FINDER(filewith)
    % open finder in a scripts folder
    
    %% warnings
    
    %% function
    assertFile(filewith);
    dirwith = fileparts(which(filewith));
    eval(sprintf('!open %s',dirwith));
end
