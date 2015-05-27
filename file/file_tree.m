
function [file] = file_tree(path,mode)
    %% [file] = FILE_TREE(path,mode)
    % list a tree of files and directories in a cell
    % path : directory to list
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
    file = auxiliar1(path);
    
    % set mode
    file = auxiliar2(file,mode);
    
end

%% auxiliar

% recursive function
function file = auxiliar1(path)
    % list
    [file,dirs] = file_list(path,'relative');
    % recursivity
    for i = 1:length(dirs)
        if dirs(i)
            file{i} = auxiliar1(file_endsep(file{i}));
        end
    end
end

% change the path to local/relative/absolute
function file = auxiliar2(file,mode)
    for i = 1:length(file)
        if ischar(file{i})
            switch mode
                case 'local'
                        file{i} = strsplit(file{i},filesep);
                        file{i} = file{i}{end};
                case 'relative'
                case 'absolute'
                    for i = 1:length(file)
                        file{i} = file_rel2abs(file{i});
                    end
                otherwise
                    error('file_tree: mode "%s" not valid',mode);
            end
        else
            file{i} = auxiliar2(file{i},mode);
        end
    end
end