
function with_edit(filewith,fileedit)
    %% WITH_EDIT(filewith,fileedit)
    
    %% warnings
    
    %% function
    assertExist(filewith);
    dirwith = fileparts(which(filewith));
    assert(isdir(dirwith),'with_edit: error. directory "%s" doesn''t exist',dirwith);
    pathedit = [dirwith,filesep(),fileedit];
    fprintf('with_edit: editing path "%s" \n',pathedit);
    edit(pathedit);
end
