
function path = file_nendsep(path)
    %% path = FILE_NENDSEP(path)
    % ensure not having a filesep symbol at the end of the path
    
    %% function
    
    % assert
    assertExist('path');
    assert(~isempty(path),'file_endsep: error. path is empty');
    
    % cell
    if iscellstr(path)
        for i = 1:numel(path)
            path{i} = file_nendsep(path{i});
        end
        return;
    end
    
    % char
    if path(end)==filesep(), path(end) = []; end
    
end
