
function assignbase(varargin)
    %% ASSIGNBASE(names)
    % assign values to the base workspace
    
    %% warning
    
    %% function
    names = varargin;
    for i = 1:length(names)
        name = names{i};
        evalin('caller',['assertExist(''',name,''');']);
        value = evalin('caller',[name,';']);
        assignin('base',name,value);
    end
    
end