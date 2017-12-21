
function varargout = file_loadvar(varargin)
    %% [val1,val2,..] = FILE_LOADVAR(path,var1,var2,..)
    % load some variables [var] from mat-file [path]
    % path : file to load
    % var  : string with the variable
    % val  : value of variable
    
    %% function
    path = varargin{1};
    var = varargin(2:end);
    mat = load(path,var{:});
    varargout = cell(size(var));
    for i = 1:length(var)
        varargout{i} = mat.(var{i});
    end
end
