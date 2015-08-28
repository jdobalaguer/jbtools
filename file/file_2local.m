
function local = file_2local(path)
    %% path = FILE_2LOCAL(path)
    % transform path to "local"
    
    %% function
    
    % char
    if ischar(path)
        [~,n,e] = fileparts(path);
        local = strcat(n,e);
        return;
    end
    
    % cell
    assertCell(path);
    local = cell(size(path));
    for i = 1:numel(path)
        local{i} = file_2local(path{i});
    end
end
