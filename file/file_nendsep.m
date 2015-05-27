
function path = file_nendsep(path)
    %% path = FILE_NENDSEP(path)
    % ensure not having a filesep symbol at the end of the path
    
    %% function
    assertExist('path');
    assert(~isempty(path),'file_endsep: error. path is empty');
    if path(end)==filesep(), path(end) = []; end
    
end
