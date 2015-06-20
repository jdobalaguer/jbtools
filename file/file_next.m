
function path = file_next(path)
    %% path = FILE_NEXT(path)
    % return the same path without the extension
    % path : string specifying the pattern
    
    %% function
    
    % char
    if ischar(path)
        [path,name] = file_parts(path);
        path = fullfile(path,name);
        return;
    end
    
    % cell
    assertCell(path);
    for i = 1:numel(path)
        path{i} = file_next(path{i});
    end
end
