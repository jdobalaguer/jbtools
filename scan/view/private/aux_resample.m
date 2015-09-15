
function n = aux_resample(t,z)
    %% n = aux_RESAMPLE(t,z)
    % resample template [t] to size [z]
    
    %% function
    disp('aux_resample');
    
    s = size(t); ... original size
    r = s ./ z; ... resolution
    fx = floor(1:r(1):s(1)); ... floor voxels
    fy = floor(1:r(2):s(2));
    fz = floor(1:r(3):s(3));
    cx =  ceil(1:r(1):s(1)); ... ceil voxels
    cy =  ceil(1:r(2):s(2));
    cz =  ceil(1:r(3):s(3));
    n  = .125 * (t(fx,fy,fz) + t(fx,fy,cz) + t(fx,cy,fz) + t(fx,cy,cz) + t(cx,fy,fz) + t(cx,fy,cz) + t(cx,cy,fz) + t(cx,cy,cz)); ... average of the 8 corners
end
