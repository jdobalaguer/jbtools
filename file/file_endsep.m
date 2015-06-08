
function path = file_endsep(path)
    %% path = FILE_ENDSEP(path)
    % ensure a filesep symbol at the end of the path
    
    %% function
    
    % assert
    assertExist('path');
    assert(~isempty(path),'file_endsep: error. path is empty');
    
    % cell
    if iscellstr(path)
        for i = 1:numel(path)
            path{i} = file_endsep(path{i});
        end
        return;
    end
    
    % char
    if path(end)~=filesep(), path(end+1) = filesep(); end
    
end
