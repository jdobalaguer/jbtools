
function file_savevar(varargin)
    %% FILE_SAVEVAR(file,version,var1,val1,var2,..)
    % load some variables [var] from mat-file [file]
    % file    : file to load
    % version : version to save (default v7)
    % var     : string with the variable
    % val     : value of variable
    
    %% function
    file = varargin{1};
    version = varargin{2};
    pair = varargin(3:end);
    func_default('version','-v7');
    s = pair2struct(pair); %#ok<NASGU>
    save(file,version,'-struct','s');
end
