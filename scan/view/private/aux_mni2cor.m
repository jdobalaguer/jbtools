
function cor = aux_mni2cor(mni,mat)
    %% mni = AUX_MNI2COR(cor,mat)
    % transformation of coordinates to MNI
    % cor : coordinates in native space
    % mat : coordinates matrix (in the header of the volume)
    % mni : coordinates in MNI space
    
    %% function
    disp('aux_mni2cor');
    cor = mat\[mni(:,1) mni(:,2) mni(:,3) ones(size(mni,1),1)]';
    cor(4,:) = [];
    cor = cor';
end
