
function file_savevar(varargin)
    %% FILE_SAVEVAR(path,version,var1,val1,var2,..)
    % save some variables [var] from mat-file [path]
    % path    : file to save
    % version : version to save (default v7)
    % var     : string with the variable
    % val     : value of variable
    
    %% function
    if mod(nargin,2),
        warning('file_savevar: warning. most likely you forgot the version. will take the default one');
        varargin = [varargin(1),{[]},varargin(2:end)];
    end
    path = varargin{1};
    version = varargin{2};
    pair = varargin(3:end);
    func_default('version','-v7');
    s = pair2struct(pair); %#ok<NASGU>
    file_mkdir(file_parts(path));
    save(path,version,'-struct','s');
end
