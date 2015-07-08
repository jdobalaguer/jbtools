
function b = file_exist(path)
    %% [file,dirs] = FILE_EXIST(path)
    % check whether a file or directory exists
    % path : path to file or directory
    
    %% function
    b = ismember(exist(path),[2,7]); %#ok<EXIST>
end
