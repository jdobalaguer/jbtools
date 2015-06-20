
function size = file_size(path)
    %% s = file_SIZE(path)
    % get size of a file in bytes, set of files, or directory/ies
    % path : path to file/directorty (or pattern)
    % size : total size in bytes
    
    %% function
    
    % default
    func_default('path','*');
    
    % fix path
    if file_ndire(path)==1 && ~file_isdire(path)
        path = file_endsep(file_match(path,'relative'));
    end
        
    % list
    list = dir(path);
    file = {list.name}';
    byts = [list.bytes]';
    dirs = [list.isdir]';
    dots = cellfun(@(d)d(1) == '.',file);
    file(dots) = [];
    dirs(dots) = [];
    byts(dots) = [];
    
    % sum up bytes
    size = 0;
    for i = 1:length(file)
        if dirs(i)
            size = size + file_size(fullfile(path,file{i}));
        else
            size = size + byts(i);
        end
    end

    
end
