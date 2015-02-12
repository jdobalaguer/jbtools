
function b = isfieldp(s,f)
    %% ISFIELDP(s,f)
    % check whether all (sub)fields exist (recursively)

    %% warning
    %#ok<>
    
    %% function
    
    % assert
    re = regexp(f,'(\w*.)*\w*','match');
    assert(length(re)==1,  'isfieldp: error. f not in right format "*.*.*"');
    assert(strcmp(f,re{1}),'isfieldp: error. f not in right format "*.*.*"');
    
    b = false;
    f = regexp(f,'\.','split');
    while ~isempty(f)
        if ~isfield(s,f{1}), return; end
        s = s.(f{1});
        f(1) = [];
    end
    b = true;
end