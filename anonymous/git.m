
function git(varargin)
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