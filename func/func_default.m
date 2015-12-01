
function func_default(var,val)
    %% FUNC_DEFAULT(var,val)
    % if [var] doesn't exist, define it as [val]
    % [var] and [val] can be cells

    %% notes
    % TODO: allow struct fields.
    
    %% function
    
    % default
    if ischar(var)
        var = {var};
        val = {val};
    else
        assert(iscellstr(var),        'func_default: error. [var] is not a cell of strings');
        assert(iscell(val),           'func_default: error. [val] is not a cell');
    end
    
    % assert
    % (these ones dont use more fancy assert because of recursive calls)
    assert(isequal(size(var),size(val)),'func_default: error [var] and [val] have different sizes');
    assert(isvector(var),'func_default: error [var] must be a vector');
    assert(isvector(val),'func_default: error [val] must be a vector');
    
    % do
    for i = 1:length(var)
        if any(var{i}=='.')
            try    doit = evalin('caller',sprintf('isempty(%s);',var{i}));
            catch, doit = true;
            end
            if doit
                if ~evalin('caller','exist(''foo'',''var'');');
                    assignin('caller','foo',val{i});
                    evalin('caller',sprintf('%s = foo;',var{i}));
                    evalin('caller','clear(''foo'');');
                else
                    warning('func_default: warning. struct field "%s" not possible to set to default (try to clear variable "foo")',var{i});
                end
            end
            continue;
        end
        if ~evalin('caller',sprintf('exist(''%s'',''var'');',var{i})) || evalin('caller',sprintf('isempty(%s);',var{i}))
            assignin('caller',var{i},val{i});
        end
    end
end
