
function assignbase(names)
    %% ASSIGNBASE(names)
    % assign values to the base workspace
    
    %% warning
    
    %% function
    if ischar(names), names = {names}; end
    assert(iscell(names), 'assignbase: error. [names] must be a string or a cell');
    for i = 1:length(names)
        name = names{i};
        evalin('caller',['assertExist(''',name,''');']);
        value = evalin('caller',[name,';']);
        assignin('base',name,value);
    end
    
end