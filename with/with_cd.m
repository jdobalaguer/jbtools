
function with_cd(filewith)
    %% WITH_CD(filewith)
    % cd to a scripts folder
    
    %% warnings
    
    %% function
    assertFile(filewith);
    dirwith = fileparts(which(filewith));
    cd(dirwith);
end
