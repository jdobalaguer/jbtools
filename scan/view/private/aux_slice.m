
function c = aux_slice(data,matrix,mni,r,method)
    %% c = AUX_SLICE(data,matrix,plane)
    % find the interpolated values of a 3D slice within a cube
    % data   : data of the volume
    % matrix : transformation matrix
    % mni    : coordinates of the plane in MNI space

    %% notes
    % see http://uk.mathworks.com/matlabcentral/newsreader/view_thread/285007
    % see http://uk.mathworks.com/matlabcentral/answers/10446-using-slice-on-a-3d-image-volume
    % see help slice
    % see interp
    % see procrustes
    % see spm_reslice
    % see interp3
    % see TFORMARRAY and IMTRANSFORM
    % see http://what-when-how.com/graphics-and-guis-with-matlab/volume-visualization-plotting-in-three-dimensions-matlab-part-1/
    
    %% example
    % [x,y,z] = meshgrid(-2:.04:2,-2:.05:2,-2:.032:2);
    % v = x.*exp(-x.^2-y.^2-z.^2);
    % figure
    % colormap hsv
    % k = 0.05;
    % 
    % hsp = surf(linspace(-2,2,20),linspace(-2,2,20),zeros(20) + k);
    % rotate(hsp,[1,-1,1],30)
    % xd = hsp.XData;
    % yd = hsp.YData;
    % zd = hsp.ZData;
    % delete(hsp)
    % 
    % slice(x,y,z,v,[-2,2],2,-2) % Draw some volume boundaries
    % hold on
    % h = slice(x,y,z,v,xd,yd,zd)
    % hold off
    % view(-5,10)
    % axis([-2.5 2.5 -2 2 -2 4])
    % drawnow
    
    %% function
    
    % get data coordinates
    s = size(data);
    [xx,yy,zz] = meshgrid(1:s(1),1:s(2),1:s(3));
    
    % transform data
    data = permute(data,[2,1,3]);
    
    % get mni plane coordinates
    cor  = aux_mni2cor(mni,matrix);
    xcor = reshape(cor(:,1),r);
    ycor = reshape(cor(:,2),r);
    zcor = reshape(cor(:,3),r);
    
    % slice plane in native coordinates
    a = matlab.graphics.axis.Axes();
    h = slice(a,xx,yy,zz,data,xcor,ycor,zcor,method);
    
    % get values
    c = get(h,'CData');
    
    % delete slice / axis
    delete(h); delete(a);
end