
function with_copy(filewith,fileedit)
    %% WITH_COPY(filewith,fileedit)
    % copy a file from the path in the current directory
    % filewith : a file which is in the target directory
    % fileedit : the file you want to copy
    
    %% function
    func_default('fileedit',filewith)
    assertExist(filewith);
    [dirwith,filewith,extwith] = fileparts(which(filewith));
    [~,      fileedit,extedit] = fileparts(fileedit);
    if isempty(extedit), extedit = extwith; end
    assert(isdir(dirwith),'with_copy: error. directory "%s" doesn''t exist',dirwith);
    pathwith = [dirwith,filesep(),fileedit,extedit];
    pathedit = [pwd(),  filesep(),fileedit,extedit];
    fprintf('with_copy: copying file "%s" here \n',pathwith);
    copyfile(pathwith,pathedit);
end
