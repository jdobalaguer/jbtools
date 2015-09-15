
function obj = mask_callback(obj)
    %% obj = MASK_CALLBACK(obj)

    %% function
    disp('mask_callback');

    % figure
    set(obj.fig.mask.figure,'CloseRequestFcn',@closeMask);
    
    %% nested functions
    function closeMask(mask,~),  obj = mask_callback_close(obj,mask); end
end
