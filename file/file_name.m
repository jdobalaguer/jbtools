
function path = file_name(path)
    %% path = FILE_NAME(path)
    % return the name
    % path : string specifying the pattern
    
    %% function
    
    % char
    if ischar(path)
        [~,path] = file_parts(path);
        return;
    end
    
    % cell
    assertCell(path);
    for i = 1:numel(path)
        path{i} = file_name(path{i});
    end
end
