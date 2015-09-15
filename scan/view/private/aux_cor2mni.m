
function mni = aux_cor2mni(cor,mat)
    %% mni = AUX_COR2MNI(cor,mat)
    % transformation of coordinates to MNI
    % cor : coordinates in native space
    % mat : coordinates matrix (in the header of the volume)
    % mni : coordinates in MNI space
    
    %% function
    disp('aux_cor2mni');
    mni = mat*[cor(:,1) cor(:,2) cor(:,3) ones(size(cor,1),1)]';
    mni(4,:) = [];
    mni = mni';
end
