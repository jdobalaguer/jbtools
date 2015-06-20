
function [path,name,ext] = file_parts(path)
    %% [path,name,ext] = FILE_PARTS(path)
    % find a file that matches a pattern, and return the complete path
    % (if given a directory, it takes the directory as the file)
    % path : string specifying the pattern
    
    %% function
    path = file_nendsep(path);
    [path,name,ext] = fileparts(path);
    if ~isempty(path), path = file_endsep(path); end
end
