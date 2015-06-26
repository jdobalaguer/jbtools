
function ext = file_ext(path)
    %% ext = FILE_EXT(path)
    % return the extension
    % path : string specifying the pattern
    
    %% function
    
    % char
    if ischar(path)
        [~,~,ext] = file_parts(path);
        return;
    end
    
    % cell
    assertCell(path);
    ext = cell(size(path));
    for i = 1:numel(path)
        ext{i} = file_ext(path{i});
    end
end
