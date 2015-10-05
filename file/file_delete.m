
function file_delete(path)
    %% FILE_DELETE(path)
    % remove a (non-empty) directory, the simple way
    
    %% function
    if isempty(path); return; end
    if isempty(file_list(path)); return; end
    delete(path);
end

