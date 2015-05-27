
function func_default(var,val)
    %% FUNC_DEFAULT(var,val)
    % if [var] doesn't exist, define it as [val]
    % [var] and [val] can be cells
    % TODO: allow struct fields.
    
    %% warning
    
    %% function
    
    % default
    if ischar(var)
        var = {var};
        val = {val};
    else
        assert(iscellstr(var), 'default: error. [var] is not a cell of strings');
    end
    
    % assert
    assertSize(var,val);
    assert(isvector(var), 'default: error. [var] is not a vector');
    assert(isvector(val), 'default: error. [val] is not a vector');
    
    % do
    for i = 1:length(var)
        if any(var{i}=='.')
            warning('default: warning. struct field "%s" not allowed',var{i});
            continue;
        end
        if ~evalin('caller',sprintf('exist(''%s'',''var'')',var{i})) || evalin('caller',sprintf('isempty(%s)',var{i}))
            assignin('caller',var{i},val{i});
        end
    end
    
end