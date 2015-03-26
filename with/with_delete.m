
function with_delete(filewith)
    %% WITH_DELETE(filewith)
    % delete whichever file in path
    
    %% warnings
    
    %% function
    assertFile(filewith);
    filewith = which(filewith);
    r = input(sprintf('Do you want to delete this file ? \n"%s" \n',filewith),'s');
    if ~strcmp(r,'yes'), return; end
    delete(which(filewith));
end
