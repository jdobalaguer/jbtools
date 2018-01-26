
function varargout = file_loadvar(varargin)
    %% [val1,val2,..] = FILE_LOADVAR(path,var1,var2,..)
    % load some variables [var] from mat-file [path]
    % path : file to load
    % var  : string with the variable
    % val  : value of variable
    
    %% function
    path  = varargin{1};
    var   = cellfun(@(s)strsplit(s,'.'),varargin(2:end),'UniformOutput',false);
    first = unique(cellfun(@(v)v{1},var,'UniformOutput',false));
    mat   = load(path,first{:});
    varargout = repmat({mat},size(var));
    for i = 1:length(var)
        for j = 1:length(var{i})
            varargout{i} = varargout{i}.(var{i}{j});
        end
    end
end
