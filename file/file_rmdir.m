
function file_rmdir(path)
    %% FILE_RMDIR(path)
    % remove a (non-empty) directory, the simple way
    
    %% function
    if ~exist(path,'dir'); return; end
    rmdir(path,'s');
end

