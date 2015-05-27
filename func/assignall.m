
function assignall()
    %% ASSIGNALL()
    % assign all variables to "base" workspace
    
    %% warnings
    
    %% function
    
    % assign
    evalin('caller','clear tmp_workspace;');
    evalin('caller','jb_workspace_get');
    tmp_workspace = evalin('caller','tmp_workspace');
    assignin('base','tmp_workspace',tmp_workspace);
    evalin('base','jb_workspace_set');
    
end 
