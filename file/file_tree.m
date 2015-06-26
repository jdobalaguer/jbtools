
function [file] = file_tree(path,mode)
    %% [file] = FILE_TREE(path,mode)
    % list a tree of files and directories in a cell
    % path : directory to list (default '.')
    % mode : 'absolute' or 'relative'
    % file : cell of (cell of)* strings
    
    %% function
    
    % default
    func_default('path','.');
    func_default('mode','relative');
    
    % assert
    path = file_nendsep(path);
    assert(file_ndire(path)==1,'file_tree: error. path "%s" is not a unique directory',path);
    
    % fix path
    path = file_match(path,'relative');
    path = file_endsep(path);
    
    % recursivity list
    file = auxiliar(path,mode);
    
end

%% auxiliar

% recursive function
function file = auxiliar(path,mode)
    % list
    [file,dirs] = file_list(path,'relative');
    % recursivity
    for i = 1:length(dirs)
        if dirs(i)
            file{i} = auxiliar(file_endsep(file{i}),mode);
        else
            file{i} = file_list(file{i},mode);
        end
    end
end
