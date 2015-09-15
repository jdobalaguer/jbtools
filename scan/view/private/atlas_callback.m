
function obj = atlas_callback(obj)
    %% obj = ATLAS_CALLBACK(obj)

    %% function
    disp('atlas_callback');

    % figure
    set(obj.fig.atlas.figure,'CloseRequestFcn',@closeAtlas);
    
    %% nested functions
    function closeAtlas(atlas,~),  obj = atlas_callback_close(obj,atlas); end
end
