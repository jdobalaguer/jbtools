
function path = file_endsep(path)
    %% path = FILE_ENDSEP(path)
    % ensure a filesep symbol at the end of the path
    
    %% function
    assertExist('path');
    assert(~isempty(path),'file_endsep: error. path is empty');
    if path(end)~=filesep(), path(end+1) = filesep(); end
    
end
