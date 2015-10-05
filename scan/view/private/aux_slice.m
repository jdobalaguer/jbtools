
function c = aux_slice(data,matrix,mni,r,method)
    %% c = AUX_SLICE(data,matrix,plane)
    % find the interpolated values of a 3D slice within a cube
    % data   : data of the volume
    % matrix : transformation matrix
    % mni    : coordinates of the plane in MNI space

    %% see also
    % see http://uk.mathworks.com/matlabcentral/newsreader/view_thread/285007
    % see http://uk.mathworks.com/matlabcentral/answers/10446-using-slice-on-a-3d-image-volume
    % see help slice
    % see interp
    % see procrustes
    % see spm_reslice
    % see interp3
    % see TFORMARRAY and IMTRANSFORM
    % see http://what-when-how.com/graphics-and-guis-with-matlab/volume-visualization-plotting-in-three-dimensions-matlab-part-1/
    
    %% notes
    % 1. in fast mode, i have no clue why i'm only supposed to flip the 1st dimension, and only when slicing the 3rd dimension.
    
    %% function
    
    % get data coordinates
    s = size(data);
    [xx,yy,zz] = meshgrid(1:s(1),1:s(2),1:s(3));
    
    % get mni plane coordinates
    cor  = aux_mni2cor(mni,matrix);
    
    % FAST MODE
    % this only happens when the volume has the right orientation
    % and the resolution is the normal one (i.e. 'Med')
    if isdiag(matrix(1:3,1:3))
        u_cor = arrayfun(@(i)unique(cor(:,i)),1:3,'UniformOutput',false);
        ii_cor = cellfun(@isscalar,u_cor);
        if all(s(~ii_cor)==r)
            % out of bounds, all black
            p_cor = round(u_cor{ii_cor});
            if p_cor<0 || p_cor>s(ii_cor), c = nan(r); return; end
            % flip the matrix if required
            % return the slice
            switch find(ii_cor)
                case 1
%                     for i = [2,3], if matrix(i,i)<0, data = flip(data,i); end; end
                    c = squeeze(data(p_cor,:,:));
                case 2
%                     for i = [1,3], if matrix(i,i)<0, data = flip(data,i); end; end
                    data = flip(data,1);
                    c = squeeze(data(:,p_cor,:));
                case 3
                    for i = [1,2], if matrix(i,i)<0, data = flip(data,i); end; end
                    c = squeeze(data(:,:,p_cor));
            end
            return;
        end
    end
    
    % SLOW MODE
    % if fast mode can't be used, then do the interpolation
    
    % get mni plane coordinates
    xcor = reshape(cor(:,1),r);
    ycor = reshape(cor(:,2),r);
    zcor = reshape(cor(:,3),r);
    
    % transform data
    data = permute(data,[2,1,3]);
    
    % slice plane in native coordinates
    a = matlab.graphics.axis.Axes();
    if all(isnan(data(:))), c = nan(r); return; end
    h = slice(a,xx,yy,zz,data,xcor,ycor,zcor,method);
    
    % get values
    c = get(h,'CData');
    
    % delete slice / axis
    delete(h); delete(a);
end