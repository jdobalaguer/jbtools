
function [xbox,ybox,zbox] = aux_getBox(volume)
    %% [xbox,ybox,zbox] = AUX_GETBOX(volume)

    %% function
    disp('aux_getBox');
    
    xbox = ranger(volume.mni.x);
    ybox = ranger(volume.mni.y);
    zbox = ranger(volume.mni.z);
end
