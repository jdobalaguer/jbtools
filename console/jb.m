
function jb(varargin)
    %% JB()
    % string console. evaluates a string with additional operators
    % ++  increment
    % --  decrement
    % +=  sum
    % -=  rest
    % ?   if end
    % ?:  if else end
    % ¬   assign
    % ¬:  assign or
    
    %% WARNING
    %#ok<*MATCH2,*AGROW,*DEFNU>
    
    %% CONSOLE
    cmd = concat(varargin{:});      % concat
    one = ~isempty(cmd);            % loop
    out = false;
    ind = 1;
    while ~out
        if (one) || (ind>1)
            ops = split(cmd);       % split
            ops = empty(ops);       % empty
            ops = parse(ops);       % parse
            cmd = concat(ops{:});   % concat
%                 print(cmd);         % print
            try
                evalin('caller', cmd);  % eval
            catch err
                cprintf([0.8,0.5,0.1],err.message);
                fprintf('\n');
            end
        end
        cmd = enter(one,ind);       % input
        out = leave(cmd);           % leave
        ind = ind + 1;              % index
    end
end

%% AUXILIAR: enter
function cmd = enter(one,ind)
    if one, cmd = 'exit';
    else
            cprintf([0.5,0.8,0.1],'%03i > ',ind);
            cmd = input('','s');
    end
end

%% AUXILIAR: exit
function out = leave(cmd)
    out = any(strcmp(cmd,{'exit'}));
end

%% AUXILIAR: print command
function print(cmd)
    fprintf('cmd : «%s»\n',cmd);
end

%% AUXILIAR: concatenate command
function cmd = concat(varargin)
    cmd = [varargin ; repmat({' '},1,length(varargin))];
    cmd = [cmd{:}];
end

%% AUXILIAR: split command
function ops = split(cmd)
    s = {'(',')','++','--','+=','-=','¬','?',':'};
    for i = 1:length(s), cmd = strrep(cmd,s{i},[' ',s{i},' ']); end
    ops = regexp(cmd,'\s*','split');
end

%% AUXILIAR: empty operators
function ops = empty(ops)
    ops(cellfun('isempty', ops)) = [];
end

%% AUXILIAR: parse parenthesis
function nps = parse(ops)
    if isempty(ops), nps = {}; return; end
    ii_open  = strcmp(ops,'(');
    ii_close = strcmp(ops,')');
    cs_open  = cumsum(ii_open);
    cs_close = cumsum(ii_close);
    assert(cs_open(end) == cs_close(end),   'jb: error. unbalanced or unexpected parenthesis (e1)');
    assert(all(cs_open >= cs_close),        'jb: error. unbalanced or unexpected parenthesis (e2)');
    cs_count = cs_open - cs_close;
    df_count = diff([0,cs_count] > 0);
    inits = find(df_count == +1);
    stops = find(df_count == -1);
    assert(length(inits)==length(stops),    'jb: error. unbalanced or unexpected parenthesis (e3)');
    if isempty(inits) && isempty(stops)
        nps = translate(ops);
        return;
    end
    nps = ops(1:inits(1)-1);
    inits(end+1) = length(ops)+1;
    for i = 1:length(stops)
        parok = true;
        if any(strcmp(parse(ops(inits(i)+1 : stops(i)-1  )),';')), parok = false; end
        if any(strcmp(parse(ops(inits(i)+1 : stops(i)-1  )),'=')), parok = false; end
        if parok, nps = [nps , {'('} , parse(ops(inits(i)+1 : stops(i)-1  )) ,{')'}];
        else      nps = [nps ,         parse(ops(inits(i)+1 : stops(i)-1  ))       ];
        end
        nps = [nps , ops(stops(i)+1 : inits(i+1)-1)];
    end
    nps = translate(nps);
end

%% AUXILIAR: translate operators
function ops = translate(ops)
    % increment
    ff = sort(strmatch('++',ops),'descend');
    if ~isempty(ff), for i = ff, ops = [ops{1:i-2} , ops{i-1}, {'='} , ops{i-1} , {'+'}, {'1'} , {';'} , ops{i+1:end} ];     end; end
    
    % decrement
    ff = sort(strmatch('--',ops),'descend');
    if ~isempty(ff), for i = ff, ops = [ops{1:i-2} , ops{i-1}, {'='} , ops{i-1} , {'-'}, {'1'} , {';'} , ops{i+1:end} ];     end; end
    
    % sum
    ff = sort(strmatch('+=',ops),'descend');
    if ~isempty(ff), for i = ff, ops = [ops{1:i-2} , ops{i-1}, {'='} , ops{i-1} , {'+'}, ops{i+1} , {';'} , ops{i+2:end} ];  end; end

    % rest
    ff = sort(strmatch('-=',ops),'descend');
    if ~isempty(ff), for i = ff, ops = [ops{1:i-2} , ops{i-1}, {'='} , ops{i-1} , {'-'}, ops{i+1} , {';'} , ops{i+2:end} ];  end; end
    
    % assign
    fi = sort(strmatch('¬',ops),'descend');
    fe = sort(strmatch(':',ops), 'ascend');
    if length(fi)==1 && length(fe)==1, ops = [{'try'} , ops(1:fi-1) , {'='} , ops(fi+1:fe-1) , {';'} , {'catch'} , ops(1:fi-1) , {'='} , ops(fe+1:end) , {';'} , {'end'} , {';'} ]; end
    
    % if end / if else end
    fi = sort(strmatch('?',ops),'descend');
    fe = sort(strmatch(':',ops), 'ascend');
    if length(fi)==1
        if length(fe)==1, ops = [{'if'} , ops(1:fi-1) , {','} , ops(fi+1:fe-1) , {';'} , {'else'} , ops(fe+1:end) , {';'} , {'end'} , {';'} ];
        else              ops = [{'if'} , ops(1:fi-1) , {','} , ops(fi+1:end)  , {';'} , {'end'} , {';'}];
        end
    end
end
