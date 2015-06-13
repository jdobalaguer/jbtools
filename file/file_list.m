
function [file,dirs] = file_list(path,mode)
    %% [file,dirs] = FILE_LIST(path,mode)
    % list all files and directories in a cell
    % if you want to list files within a directory, use the ending filesep.
    % path : directory to list
    % mode : 'absolute' or 'relative'
    % file : cell of strings
    % dirs : logical array with directory flag
    
    %% function
    func_default('path','*');
    func_default('mode','local');
    
    % if it hasn't been specified as a directory, and it's a directory
    % then you shouldn't look inside it
    if ~file_isdire(path) && exist(path,'dir')==7
        dirs = true;
        switch(mode)
            case 'local'
                file = strsplit(path,filesep);
                file = file(end);
            case 'relative'
                file = {path};
            case 'absolute'
                file = {file_2absolute(path)};
            otherwise
                error('file_list: mode "%s" not valid',mode);
        end
        return;
    end
        
    % otherwise, you have two cases: either you list all possible matches
    % a particular pattern specified by [path], or it's clearly specified
    % that you want to list things within the directory (because of the
    % final filesep)
    list = dir(path);
    file = {list.name}';
    dirs = [list.isdir]';
    dots = cellfun(@(d)d(1) == '.',file);
    file(dots) = [];
    dirs(dots) = [];
    switch(mode)
        case 'local'
        case 'relative'
            for i = 1:length(file)
                file{i} = [fileparts(path),filesep,file{i}];
            end
        case 'absolute'
            for i = 1:length(file)
                file{i} = file_2absolute([fileparts(path),filesep,file{i}]);
            end
        otherwise
            error('file_list: mode "%s" not valid',mode);
    end

end