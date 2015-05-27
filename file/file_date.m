
function date = file_date(path)
    %% date = FILE_DATE(path)
    % get size of file in path (can be a pattern)
    % path : path to file (or unambiguous pattern)
    % date : date string
    
    %% function
    path = file_match(path);
    date = dir(path);
    date = date.date;
    
end
