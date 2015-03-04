
function git(varargin)
    %% GIT(cmd)
    % execute a git command
    
    %% warnings
    
    %% function
    assertUnix('this function only works in unix');
    assert(nargin>0,'git: error. no input given');
    
    % parse
    if strcmp(varargin{1},'pum'),
        cmd{1} = 'git commit -m "automatic upload"';
        cmd{2} = 'git push';
    else
        args = sprintf(' %s',varargin{:});
        cmd{1}  = ['git',args];
    end
    % execute
    for i = 1:length(cmd);
        cprintf('*black','git: execute command "%s"\n',cmd{i});
        unix(cmd{i});
    end
end