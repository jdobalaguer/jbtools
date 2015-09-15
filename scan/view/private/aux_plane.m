
function mni = aux_plane(x,y,z)
    %% mni = AUX_PLANE(ux,uy)
    
    %% function
    disp('aux_plane');
    [xx,yy,zz] = ndgrid(x,y,z);
    mni = [xx(:),yy(:),zz(:)];
end