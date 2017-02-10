
function mm = scan_tool_voxelsize(scan,meta) %#ok<INUSL>
    %% mm = SCAN_TOOL_VOXELSIZE(scan,meta)
    % get the size of voxels (in mm)
    
    %% notes
    % this is based on xu cui's function @cor2mni
    
    %% function
    mm(1) = sqrt(sum(power(cor2mni([2,1,1],meta.mat) - cor2mni([1,1,1],meta.mat),2)));
    mm(2) = sqrt(sum(power(cor2mni([1,2,1],meta.mat) - cor2mni([1,1,1],meta.mat),2)));
    mm(3) = sqrt(sum(power(cor2mni([1,1,2],meta.mat) - cor2mni([1,1,1],meta.mat),2)));
end

%% auxiliar
function mni = cor2mni(cor,T)
    cor = round(cor);
    mni = T*[cor(:,1) cor(:,2) cor(:,3) ones(size(cor,1),1)]';
    mni = mni';
    mni(:,4) = [];
end
