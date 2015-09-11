
function b = aux_string2bool(s)
    %% b = AUX_STRING2BOOL(s)
    % return 'on' or 'off'
    
    %% function
    disp('aux_string2bool');

    b = nan;
    switch(s)
        case 'on',  b = true;  return;
        case 'off', b = false; return;
    end
end
