
function h = aux_db(obj,slice,parent)
    %% h = AUX_DB(obj,slice,parent)
    % display the background (ignoring the colormap)
    
    %% function
    disp('aux_db');
    
    % grid
    z = zeros(mat_size(slice,[1,2]));
    c = repmat(slice,[1,1,3]);
    
    % plot
    h = surface(z,c,'Parent',parent,'LineStyle','none','EdgeColor','none');
end
