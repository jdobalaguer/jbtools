
function b = struct_isfield(s,f)
    %% STRUCT_ISFIELD(s,f)
    % check whether all (sub)fields exist (recursively)
    % s : struct
    % f : string with format "field1.field2.field3.."

    %% function
    
    % assert
    re = regexp(f,'(\w*.)*\w*','match');
    assert(length(re)==1,  'struct_isfield: error. f not in right format "*.*.*"');
    assert(strcmp(f,re{1}),'struct_isfield: error. f not in right format "*.*.*"');
    
    % do
    b = false;
    f = regexp(f,'\.','split');
    while ~isempty(f)
        if ~isfield(s,f{1}), return; end
        if isempty(s) && isscalar(f), break; end
        s = s.(f{1});
        f(1) = [];
    end
    b = true;
end
