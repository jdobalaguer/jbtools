
function git(varargin)
    %% GIT(cmd)
    % execute a git command
    
    %% function
    assertUnix();
    assert(nargin>0,'git: error. no input given');
    
    % parse
    if strcmp(varargin{1},'pum'),
        if nargin == 1
            cmd{1} = 'git commit -m "automatic upload"';
        else
            msg = sprintf('%s ',varargin{2:end});
            msg(end) = [];
            cmd{1} = sprintf('git commit -m "%s"',msg);
            clear msg;
        end
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