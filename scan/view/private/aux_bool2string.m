
function s = aux_bool2string(b)
    %% s = AUX_BOOL2STRING(b)
    % return 'on' or 'off'
    
    %% function
    disp('aux_bool2string');
    
    s = 'off';
    if b, s = 'on'; end
end
