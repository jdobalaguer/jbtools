
function c = aux_MNIcoordinates(s,t)
    %% c = aux_MNIcoordinates(s,t)
    % get MNI coordinates for each voxel
    
    %% function
    disp('aux_MNIcoordinates');
    
    u = arrayfun(@(s)1:s,s,'UniformOutput',false);
    [c{1:3}] = ndgrid(u{:});
    c = cellfun(@mat2vec,c,'UniformOutput',false);
    c = cat(2,c{:});
    c = aux_cor2mni(c,t);
    c = reshape(c,[s,3]);
    c = mat2vec(mat2cell(c,s(1),s(2),s(3),[1,1,1]));
    c = struct('x',c(1),'y',c(2),'z',c(3));
end
