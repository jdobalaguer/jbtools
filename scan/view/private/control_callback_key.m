
function obj = control_callback_key(obj,evt)
    %% obj = CONTROL_CALLBACK_KEY(obj,evt)

    %% function
    disp('control_callback_key');

    % apply key
    switch strcat(sprintf('%s:',evt.Modifier{:}),evt.Key)
        
        % switch to another window
        case 'control:s',        aux_switchWindow(obj,'control'); return;
        case 'control:v',        aux_switchWindow(obj,'viewer'); return;
        case 'control:g',        aux_switchWindow(obj,'glass'); return;
        case 'control:m',        aux_switchWindow(obj,'mask'); return;
        case 'control:a',        aux_switchWindow(obj,'atlas'); return;
        case 'control:r',        aux_switchWindow(obj,'render'); return;
            
        % nothing
        otherwise, return;
    end
end
