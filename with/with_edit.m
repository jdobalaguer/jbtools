
function with_edit(filewith,fileedit)
    %% WITH_EDIT(filewith,fileedit)
    
    %% warnings
    
    %% function
    assertExist(filewith);
    dirwith = fileparts(which(filewith));
    assert(isdir(dirwith),'editwith: error. directory "%s" doesn''t exist',dirwith);
    pathedit = [dirwith,filesep(),fileedit];
    fprintf('editwith: editing path "%s" \n',pathedit);
    edit(pathedit);
end
